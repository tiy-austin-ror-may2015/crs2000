class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :max_occupancy
      t.integer :room_number
      t.string :imgurl
      t.string :location
      t.references :company

      t.timestamps null: false
    end
  end
end
