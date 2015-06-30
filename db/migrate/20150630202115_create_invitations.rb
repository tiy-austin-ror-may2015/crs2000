class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.belongs_to :employee
      t.belongs_to :meeting

      t.timestamps null: false
    end
  end
end
