class MeetingMailer < ApplicationMailer

  def meeting_scheduled(employee, meeting)
    @employee = employee
    @meeting = meeting

    mail to: employee.email, subject: "Meeting Scheduled"
  end

end
