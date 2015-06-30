class Room < ActiveRecord::Base
belongs_to :company
has_many :meetings
validates_presence_of :name, :max_occupancy, :location

def self.updated_room(room, params)
    room[:name]          = params[:room][:name]           if params[:room][:name]
    room[:location]      = params[:room][:location]       if params[:room][:location]
    room[:room_number]   = params[:room][:room_number]    if params[:room][:room_number]
    room[:image]         = params[:room][:image]          if params[:room][:image]
    room[:max_occupancy] = params[:room][:max_occupancy]  if params[:room][:max_occupancy]
    room
  end
 # def self.any_seats_available_at?(room_id, start_time, end_time)
 #    @room         = Room.find(room_id])
 #    room_capacity = @room.max_occupancy
 #      get meeting
 #    attendants    = @meeting_model.meetings.employee_meetings.enrolled

 #    if room_capacity > attendants ? true : false
 #  end
end
