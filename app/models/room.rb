class Room < ActiveRecord::Base
belongs_to :company
has_many :meetings
validates_presence_of :name, :max_occupancy, :location
 # def self.any_seats_available_at?(room_id, start_time, end_time)
 #    @room         = Room.find(room_id])
 #    room_capacity = @room.max_occupancy
 #      get meeting
 #    attendants    = @meeting_model.meetings.employee_meetings.enrolled

 #    if room_capacity > attendants ? true : false
 #  end
end
