class Room < ActiveRecord::Base
belongs_to :company
has_many :meetings
validates_presence_of :name, :max_occupancy, :location

def self.search_with(params)
  name = params.fetch("name", "")
  max_occupancy = params.fetch("max_occupancy", "0")
  room_number = params.fetch("room_number", "%%")
  meetings_count = params.fetch("meetings_count", "%%")
  available = params.fetch("available", "%%")
  location = params.fetch("location", "%%")
  Room.where("lower(name) LIKE lower('%#{name}%') AND
              max_occupancy >= #{max_occupancy} AND
              CAST(room_number AS TEXT) LIKE '#{room_number}' AND
              CAST(meetings_count AS TEXT) LIKE '#{meetings_count}' AND
              CAST(available AS TEXT) LIKE '#{available}' AND
              lower(location) LIKE lower('%#{location}%')")
end

def self.sort_with(params)
  sort_by = params.fetch("sort_by", "created_at||").split("||")
  sort_dir = params.fetch("sort_dir", "ASC||").split("||")
  sort_hash = Hash[sort_by.zip(sort_dir)]
  order_query = []
  sort_hash.each { |sort_by, sort_dir| order_query << "#{sort_by} #{sort_dir}" }
  order_query = order_query.join(", ")

  self.order(order_query)
end
 # def self.any_seats_available_at?(room_id, start_time, end_time)
 #    @room         = Room.find(room_id])
 #    room_capacity = @room.max_occupancy
 #      get meeting
 #    attendants    = @meeting_model.meetings.employee_meetings.enrolled

 #    if room_capacity > attendants ? true : false
 #  end
end
