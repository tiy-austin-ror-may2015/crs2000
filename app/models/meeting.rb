class Meeting < ActiveRecord::Base
  belongs_to :room
  belongs_to :employee
  has_many :employee_meetings
  after_create :update_room

  private

  def update_room
    next_meeting_start_time = Meeting.where("start_time > '#{Time.now}'").minimum(:start_time)
                           || Time.new(2038,1,19,3,14,07)
    room.update(next_meeting_start_time: next_meeting_start_time,
                              available: false)
  end
end
