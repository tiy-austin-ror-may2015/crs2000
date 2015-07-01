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

  def self.attending(meeting)
    self.where(meeting_id: meeting).count
  end

end
