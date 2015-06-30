class Joinment < ApplicationMailer
  def joined_confirmation(employee, meeting)
    @employee = employee
    @meeting = meeting

    mail to: employee.email, subject: "You've been joined the meeting!"
  end

end