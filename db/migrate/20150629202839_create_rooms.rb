class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :max_occupancy
      t.integer :room_number
      t.string :imgurl
      t.string :location
      t.references :company
      t.integer :meetings_count, default: 0
      t.boolean :available, default: true
      t.datetime :next_meeting_start_time, default: Time.new(2038,1,19,3,14,07)

      t.timestamps null: false
    end
  end
end
