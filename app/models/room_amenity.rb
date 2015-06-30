class RoomAmenity < ActiveRecord::Base
  belongs_to :room
  belongs_to :amenity
end
