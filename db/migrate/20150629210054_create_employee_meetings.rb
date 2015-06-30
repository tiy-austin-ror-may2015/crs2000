class CreateEmployeeMeetings < ActiveRecord::Migration
  def change
    create_table :employee_meetings do |t|
      t.integer :enrolled, default: 0
      t.references :employee
      t.references :meeting

      t.timestamps null: false
    end
  end
end
