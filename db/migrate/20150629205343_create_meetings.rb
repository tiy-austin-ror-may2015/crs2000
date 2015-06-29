class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :title, null: false
      t.text :agenda, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.boolean :private, default: false

      t.references :room
      t.references :employee

      t.timestamps null: false
    end
  end
end
