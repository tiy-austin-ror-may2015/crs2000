class Room < ActiveRecord::Base
belongs_to :company
has_many :meetings

 # def self.any_seats_available_at?(room_id, start_time, end_time)
 #    @room         = Room.find(room_id])
 #    room_capacity = @room.max_occupancy
 #    attendants    = @room.meetings.employee_meetings.enrolled

 #    if room_capacity > attendants ? true : false
 #  end
end
