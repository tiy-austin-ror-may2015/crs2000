class Room < ActiveRecord::Base
belongs_to :company
has_many :meetings
validates_presence_of :name, :max_occupancy, :location
validates :next_meeting_start_time, :numericality => { :greater_than_or_equal_to Time.now }
 # def self.any_seats_available_at?(room_id, start_time, end_time)
 #    @room         = Room.find(room_id])
 #    room_capacity = @room.max_occupancy
 #      get meeting
 #    attendants    = @meeting_model.meetings.employee_meetings.enrolled

 #    if room_capacity > attendants ? true : false
 #  end
end
