class Company < ActiveRecord::Base
  has_many :rooms
  has_many :employees
  has_many :meetings, through: :rooms
end
