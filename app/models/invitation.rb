class Invitation < ActiveRecord::Base
  belongs_to :employee
  belongs_to :meeting
end
