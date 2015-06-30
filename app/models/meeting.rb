class Meeting < ActiveRecord::Base
  belongs_to :room
  belongs_to :employee
  has_many :employee_meetings
end
