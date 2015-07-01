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
    company_id_query.present? ? company_id_query.prepend(" AND (") << ")" : company_id_query = " AND id = 0"

    name = params.fetch("name", "")
    max_occupancy = params.fetch("max_occupancy", "").empty? ? "-1" : params["max_occupancy"]
    room_number = params.fetch("room_number", "").empty? ? "%%" : params["room_number"]
    available = params.fetch("available", "false")
    location = params.fetch("location", "").empty? ? "%%" : params["location"]

    where_query = "lower(name) LIKE lower('%#{name}%') AND
                   max_occupancy > #{max_occupancy} AND
                   CAST(room_number AS TEXT) LIKE '#{room_number}' AND
                   available = #{available} AND
                   lower(location) LIKE lower('#{location}')" +
                   company_id_query

    100.times { puts where_query }
    Room.where(where_query)

  end

  def self.sort_with(params)
    sort_by   = params.fetch("sort_by", "name||").split("||")
    sort_dir  = params.fetch("sort_dir", "ASC||").split("||")
    sort_hash = Hash[sort_by.zip(sort_dir)]

    order_query = sort_hash.map { |sort_by, sort_dir| "#{sort_by} #{sort_dir}" }.join(", ")
    self.order(order_query)
  end

  def update_time_sensitive_values
    hours_until_next_meeting = self.meetings.where("start_time > '#{Time.now}'").minimum(:start_time) || 1.hour.ago
    hours_until_next_meeting = ((hours_until_next_meeting - Time.now) / 3600).round
    available = self.meetings.where("start_time < '#{Time.now}' AND end_time > '#{Time.now}'").none?

    self.update(hours_until_next_meeting: hours_until_next_meeting, available: available)
  end

  def self.company_rooms(company)
    self.where(company_id: company).map { |room| [room.name, room.id] }
  end

  def self.search_for(search)
    search ||= ""
    self.where("lower(name) LIKE ? OR lower(location) LIKE ? OR max_occupancy > ?",
               "%#{search.downcase}%", "%#{search.downcase}%", search.to_i)
  end

end
