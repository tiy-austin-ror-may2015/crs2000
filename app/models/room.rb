class Room < ActiveRecord::Base
belongs_to :company
has_many :meetings
validates_presence_of :name, :max_occupancy, :location

end
