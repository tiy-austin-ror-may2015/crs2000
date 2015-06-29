class FixPluralityAgreementInEmployeeMeetings < ActiveRecord::Migration
  def change
    rename_column(:employee_meetings, :meetings_id, :meeting_id)
  end
end
