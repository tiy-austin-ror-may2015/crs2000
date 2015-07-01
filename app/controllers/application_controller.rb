class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def user_is_admin?
    user = current_employee
    user.admin
  end

  def room_is_available?(requested_meeting)
    all_room_meetings = requested_meeting.room.meetings
    room_other_meetings = all_room_meetings.delete(requested_meeting)
    room_other_meetings.each do |meeting|
      if meeting.end_time > requested_meeting.start_time
        return false
      else
        true
      end
    end
  end
end
