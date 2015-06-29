class Room < ActiveRecord::Base
belongs_to :company
has_many :meetings
end
