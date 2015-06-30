class Meeting < ActiveRecord::Base
  belongs_to :room, counter_cache: true
  belongs_to :employee
  has_many :employee_meetings

  # def send_meetings(meetings)
  #   @all_meetings = [] create # create container for meetings to send

  #   meetings.each do |meeting| # loop thru meetings

  #    if meeting.private # check if meeting is private
  #     @all_meetings << meeting if current_user.id == meeting.employee.id || user_is_admin?
  #    else
  #     @all_meetings << meeting
  #    end
  #   end
  #   @all_meetings # send to display
  # end
end
