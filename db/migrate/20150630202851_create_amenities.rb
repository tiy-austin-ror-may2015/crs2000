class CreateAmenities < ActiveRecord::Migration
  def change
    create_table :amenities do |t|
      t.string :perk
      t.belongs_to :room, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
