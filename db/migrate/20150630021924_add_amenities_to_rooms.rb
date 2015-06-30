class AddAmenitiesToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :amenities, :string
  end
end
