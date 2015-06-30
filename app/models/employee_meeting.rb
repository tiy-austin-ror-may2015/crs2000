class EmployeeMeeting < ActiveRecord::Base
  belongs_to :employee
  belongs_to :meeting

  def self.attending(meeting)
    self.where(meeting_id: meeting).count
  end

end
