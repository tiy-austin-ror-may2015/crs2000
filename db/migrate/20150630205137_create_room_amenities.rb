class CreateRoomAmenities < ActiveRecord::Migration
  def change
    create_table :room_amenities do |t|
      t.belongs_to :room, index: true, foreign_key: true
      t.belongs_to :amenity, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
