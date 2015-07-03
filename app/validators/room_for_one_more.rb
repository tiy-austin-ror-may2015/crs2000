class RoomForOneMore < ActiveModel::Validator
  def validate(record)
    employee_name = record.employee.name
    meeting_attendance = record.meeting.employee_meetings.count
    max_occupancy = record.meeting.room.max_occupancy
    if meeting_attendance >= max_occupancy
      record.errors[:base] << "#{employee_name} cannot attend this meeting, it is already full!"
    end
  end
end
