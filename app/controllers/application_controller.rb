class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  def user_is_admin?
    if current_employee
      user = current_employee
      user.admin
    end
  end

  def no_meeting_overlap? (requested_meeting)
    employee_meetings = Meeting.where(employee_id: current_employee.id)
    employee_meetings += EmployeeMeeting.where(employee_id: current_employee.id).map{ |em| em.meeting }
    employee_meetings.each do |meeting|
      if requested_meeting.start_time < meeting.end_time && requsted_meeting.start_time >= meeting.start_time ||
         (meeting.start_time..meeting.end_time).cover?(requested_meeting.end_time)
        return false
      else
        true
      end
    end
  end

  def room_is_available?(requested_meeting)
    all_room_meetings = requested_meeting.room.meetings
    room_other_meetings = all_room_meetings - [requested_meeting]
    room_other_meetings.each do |meeting|
      if requested_meeting.start_time < meeting.end_time && requsted_meeting.start_time >= meeting.start_time ||
         (meeting.start_time..meeting.end_time).cover?(requested_meeting.end_time)
        return false
      else
        true
      end
    end
  end

  helper_method :user_is_admin?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :company_id
  end
end
