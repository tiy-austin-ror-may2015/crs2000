class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :max_occupancy
      t.integer :room_number
      t.string :imgurl
      t.string :location
      t.references :company
      t.integer :meetings_count
      t.boolean :available, default: true
      t.datetime :time_until_next_meeting

      t.timestamps null: false
    end
  end
end
