class MeetingMailer < ApplicationMailer

  def meeting_scheduled(employee, admin)
    @employee = employee
    @admin = admin
    recipients = [employee.email, admin.email]

    mail to: recipients, subject: "Meeting Scheduled"
  end

end
