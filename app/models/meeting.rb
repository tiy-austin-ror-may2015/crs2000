class Meeting < ActiveRecord::Base
  belongs_to :room, counter_cache: true
  belongs_to :employee
  has_many :employee_meetings
  has_many :invitations
  has_many :room_amenities

  def self.search_for(search)
    self.where("lower(title) LIKE ? OR lower(agenda) LIKE ?",
               "%#{search.downcase}%", "%#{search.downcase}%")
  end

  def self.capacity(meeting)
    self.find(meeting).room.max_occupancy
  end

end

