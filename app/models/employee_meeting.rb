# == Schema Information
#
# Table name: employee_meetings
#
#  id          :integer          not null, primary key
#  enrolled    :integer          default(0)
#  employee_id :integer
#  meeting_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class EmployeeMeeting < ActiveRecord::Base
  belongs_to :employee
  belongs_to :meeting
  validates_with RoomForOneMore
  after_create :email_invitee

  def self.attending(meeting)
    self.where(meeting_id: meeting).count
  end

  private

  def email_invitee
    MeetingMailer.meeting_scheduled(self.employee, self.meeting).deliver_now
  end
end
