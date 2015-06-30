class Meeting < ActiveRecord::Base
  belongs_to :room, counter_cache: true
  belongs_to :employee
  has_many :employee_meetings
  has_many :room_amenities
end
