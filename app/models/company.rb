class Company < ActiveRecord::Base
has_many :rooms
has_many :employees
end
