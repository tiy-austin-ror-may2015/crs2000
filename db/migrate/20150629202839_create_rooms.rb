class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :max_occupancy
      t.integer :room_number
      t.string :imgurl
      t.string :location, null: false
      t.references :company
      t.integer :meetings_count, default: 0

      t.timestamps null: false
    end
  end
end
