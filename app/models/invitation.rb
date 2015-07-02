class Invitation < ActiveRecord::Base
  belongs_to :meeting
  validates_presence_of :meeting_id, :employee_id
  belongs_to :employee

  def self.is_invited?(invitations, user_id)
    answer = false
    invitations.each { |i| answer = true if i.employee_id == user_id }
    answer
  end
end
