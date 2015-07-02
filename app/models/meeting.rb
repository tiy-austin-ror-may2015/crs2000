# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  agenda      :text             not null
#  start_time  :datetime         not null
#  end_time    :datetime         not null
#  private     :boolean          default(FALSE)
#  room_id     :integer
#  employee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Meeting < ActiveRecord::Base
  belongs_to :room, counter_cache: true
  belongs_to :employee
  has_many :employee_meetings
  has_many :employees, through: :employee_meetings
  has_many :invitations
  has_many :room_amenities
  has_many :employees, through: :employee_meetings
  has_one  :company, through: :employee
  scope :today_forward, -> { where("start_time >= ?", Time.now.midnight).order(:start_time) }


  def self.search_for(search)
    self.where("lower(title) LIKE ? OR lower(agenda) LIKE ?",
               "%#{search.downcase}%", "%#{search.downcase}%")
  end

  def self.capacity(meeting)
    self.find(meeting).room.max_occupancy
  end
end

