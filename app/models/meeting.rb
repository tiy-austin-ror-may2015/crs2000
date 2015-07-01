class Meeting < ActiveRecord::Base
  belongs_to :room, counter_cache: true
  belongs_to :employee
  has_many :employee_meetings
  has_many :employees, through: :employee_meetings

  def self.search_for(query, search)
    self.where("#{query} LIKE ?", "%" + search + "%")
  end

end
