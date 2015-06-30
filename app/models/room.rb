class Room < ActiveRecord::Base
  belongs_to :company
  has_many :meetings
  validates_presence_of :name, :max_occupancy, :location

  def self.search_with(params)
    name = params.fetch("name", "")
    max_occupancy = params.fetch("max_occupancy", "0")
    room_number = params.fetch("room_number", "%%")
    meetings_count = params.fetch("meetings_count", "%%")
    available = params.fetch("available", "%%")
    location = params.fetch("location", "%%")

    Room.where("lower(name) LIKE lower('%#{name}%') AND
                max_occupancy >= #{max_occupancy} AND
                CAST(room_number AS TEXT) LIKE '#{room_number}' AND
                CAST(meetings_count AS TEXT) LIKE '#{meetings_count}' AND
                CAST(available AS TEXT) LIKE '#{available}' AND
                lower(location) LIKE lower('%#{location}%')")
  end

  def self.sort_with(params)
    sort_by = params.fetch("sort_by", "created_at||").split("||")
    sort_dir = params.fetch("sort_dir", "ASC||").split("||")
    sort_hash = Hash[sort_by.zip(sort_dir)]
    order_query = []
    sort_hash.each { |sort_by, sort_dir| order_query << "#{sort_by} #{sort_dir}" }
    order_query = order_query.join(", ")

    self.order(order_query)
  end

  def update_time_sensitive_values
    hours_until_next_meeting = self.meetings.where("start_time > '#{Time.now}'").minimum(:start_time) || 1.hour.ago
    hours_until_next_meeting = ((hours_until_next_meeting - Time.now) / 3600).round
    available = self.meetings.where("start_time < '#{Time.now}' AND end_time > '#{Time.now}'").none?

    self.update(hours_until_next_meeting: hours_until_next_meeting, available: available)
  end

   def self.company_rooms(company)
    self.where(company_id: company).map { |room| [room.name, room.id] }
  end
end
