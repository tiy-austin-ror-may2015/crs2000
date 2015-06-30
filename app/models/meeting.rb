class Meeting < ActiveRecord::Base
  belongs_to :room, counter_cache: true
  belongs_to :employee
  has_many :employee_meetings

  def self.search_for(query, search)
    self.where("lower(#{query}) LIKE ?", "%" + search.downcase + "%")
  end

end
