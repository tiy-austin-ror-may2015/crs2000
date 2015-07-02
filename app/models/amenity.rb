class Amenity < ActiveRecord::Base
  has_many :room_amenities
  has_many :rooms, through: :room_amenities
end
