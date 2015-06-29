class Room < ActiveRecord::Base
belongs_to :company
has_many :meetings

  def self.any_seats_available_at?(room)
    @room         = Room.find(room.id])
    room_capacity = @room.max_occupancy
    attendants    = @room.meeting.employee_meetings.enrolled

    if room_capacity > attendants ? true : false
  end
end
