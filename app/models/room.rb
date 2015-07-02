# == Schema Information
#
# Table name: rooms
#
#  id                       :integer          not null, primary key
#  name                     :string
#  max_occupancy            :integer
#  room_number              :integer
#  imgurl                   :string
#  location                 :string
#  company_id               :integer
#  meetings_count           :integer          default(0)
#  available                :boolean          default(TRUE)
#  hours_until_next_meeting :integer          default(-1)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Room < ActiveRecord::Base

belongs_to :company
has_many :meetings
has_many :amenities
validates_presence_of :name, :max_occupancy, :location

def self.updated_room(room, params)
  room[:name]          = params[:room][:name]           if params[:room][:name]
  room[:location]      = params[:room][:location]       if params[:room][:location]
  room[:room_number]   = params[:room][:room_number]    if params[:room][:room_number]
  room[:imgurl]        = params[:room][:imgurl]         if params[:room][:imgurl]
  room[:max_occupancy] = params[:room][:max_occupancy]  if params[:room][:max_occupancy]
  room
end
 # def self.any_seats_available_at?(room_id, start_time, end_time)
 #    room          = Room.find(room_id])
 #    room_capacity = room.max_occupancy
 #    all_meetings  = room.meetings  # get meetings
 #    attendants    = @meeting_model.meetings.employee_meetings.enrolled

 #    if room_capacity > attendants ? true : false
 #  end

 # get room user want to look at
 # get the start_time and end_time user wants to look at
 # check if room has meeting during those times
 # if room has no meeting then room is empty
 # if room does have a meeting
 # check the number of attandents and compare to room capacity
 # send true or false

  def self.search_with(params)
    company_name = params.fetch("company_name", "")
    company_ids = Company.where("lower(name) LIKE lower('%#{company_name}%')").pluck(:id)
    company_id_query = company_ids.map{ |id| "company_id = #{id}" }.join(" OR ")
    company_id_query.present? ? company_id_query.prepend(" AND (") << ")" : company_id_query = " AND company_id = 0"

    name = params.fetch("name", "")
    max_occupancy = params.fetch("max_occupancy", "").empty? ? "-1" : params["max_occupancy"]
    room_number = params.fetch("room_number", "").empty? ? "%%" : params["room_number"]
    location = params.fetch("location", "").empty? ? "%%" : params["location"]

    where_query = "lower(name) LIKE lower('%#{name}%') AND
                   max_occupancy >= #{max_occupancy} AND
                   CAST(room_number AS TEXT) LIKE '#{room_number}' AND
                   lower(location) LIKE lower('#{location}')" +
                   company_id_query

    Room.where(where_query)
  end

  def self.company_rooms(company)
    self.where(company_id: company).map { |room| [room.name, room.id] }
  end

  def self.search_for(search)
    if search.to_i == 0
      max_occupancy = 1000
    else
      max_occupancy = search.to_i
    end
    amenity_results = Amenity.where("lower(perk) LIKE ?", "%#{search}%")
    amenity_query = amenity_results.map { |amenity| "id = #{amenity.room_id}" }.join(" OR ")
    amenity_query.present? ? amenity_query.prepend(" OR ") : amenity_query = " OR id = 0"
    search_query = "lower(name) LIKE '%#{search}%' OR lower(location) LIKE '%#{search}%'
                    OR max_occupancy > #{max_occupancy}" + amenity_query
    self.where(search_query)
  end

  def get_next_meeting_start_time_and_availability(admin)
    time = "N/A"
    available = "yes"
    now = Time.now
    unless meetings.none?
      next_start_time = meetings.first.start_time
      meetings = admin ? self.meetings : self.meetings.where(private: false)
      next_start_time = meetings.first.start_time
      meetings.each do |meeting|
        start_time = meeting.start_time
        available = "no" if start_time <= now && meeting.end_time >= now
        time = start_time if start_time > now && start_time <= next_start_time
      end
    end
    [time, available]
  end
end
