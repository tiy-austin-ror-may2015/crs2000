class MeetingMailer < ApplicationMailer

  def meeting_scheduled(employee, meeting)
    @employee = employee
    @meeting = meeting

    mail to: employee.email, subject: "Meeting Scheduled"
  end

  def meeting_cancelled(employee, meeting)
    @employee = employee
    @meeting = meeting

    mail to: employee.email, subject: "Meeting Cancelled"
  end

  def meeting_changed(employee, meeting)
    @employee = employee
    @meeting = meeting

    mail to: employee.email, subject: "Meeting Changed"
  end

  def invited_to_meeting(employee, meeting)
    @employee = employee
    @meeting = meeting

    mail to: employee.email, subject: "Invited to Meeting"
  end

end
