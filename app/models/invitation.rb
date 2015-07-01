class Invitation < ActiveRecord::Base
  belongs_to :employee
  belongs_to :meeting
  validates_presence_of :meeting_id, :employee_id
end
