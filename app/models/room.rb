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
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Room < ActiveRecord::Base

belongs_to :company
has_many :room_amenities
has_many :meetings
has_many :amenities, through: :room_amenities
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

<<<<<<< HEAD
=======
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

  def self.sort_with(params)
    sort_by   = params.fetch("sort_by", "name||").split("||")
    sort_dir  = params.fetch("sort_dir", "ASC||").split("||")
    sort_hash = Hash[sort_by.zip(sort_dir)]

    order_query = sort_hash.map { |sort_by, sort_dir| "#{sort_by} #{sort_dir}" }.join(", ")
    self.order(order_query)
  end

>>>>>>> ae0ff322f5e7f82cb024fa2d4c4b291147a41d6f
  def self.company_rooms(company)
    self.where(company_id: company).map { |room| [room.name, room.id] }
  end

  def self.search_for(params)
    search = params[:search].downcase
    max_occupancy = params["max_occupancy"].empty? ? "-1" : params["max_occupancy"]
    room_number = params["room_number"].empty? ? "%%" : params["room_number"]

    amenities = Amenity.where("lower(perk) LIKE lower('%#{search}%')")
    room_ids = amenities.map{ |amenity| amenity.rooms.pluck(:id) }.flatten.uniq

    amenity_query = room_ids.map{ |id| "id = #{id}" }.join(" OR ")
    amenity_query.empty? ? amenity_query = " AND id = 0)" : amenity_query.prepend(" AND (") << "))"
    search_query = "(lower(name) LIKE '%#{search}%'
                    OR lower(location) LIKE ('%#{search}%'))
                    OR (max_occupancy >= #{max_occupancy}
                    AND CAST(room_number AS TEXT) LIKE '#{room_number}'" + amenity_query
    self.where(search_query)
  end
<<<<<<< HEAD

  def get_next_meeting_details
    time = "N/A"
    available = "yes"
    next_meeting = nil
    now = Time.now
    unless meetings.none?
      next_start_time = self.meetings.first.start_time
      self.meetings.each do |meeting|
        start_time = meeting.start_time
        available = "no" if start_time <= now && meeting.end_time >= now
        if start_time > now && start_time <= next_start_time
          next_start_time = start_time
          time = start_time
          next_meeting = meeting
        end
      end
    end
    [time, available, next_meeting]
  end
=======
>>>>>>> ae0ff322f5e7f82cb024fa2d4c4b291147a41d6f
end
