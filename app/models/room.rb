class Room < ActiveRecord::Base
  belongs_to :company
  has_many :meetings
  validates_presence_of :name, :max_occupancy, :location

  def self.search_with(params)
    company_name = params.fetch("company_name", "")
    company_ids = Company.where("lower(name) LIKE lower('%#{company_name}%')").pluck(:id)
    company_id_query = company_ids.map{ |id| "company_id = #{id}" }.join(" OR ")
    company_id_query.present? ? company_id_query.prepend(" AND ") : company_id_query = " AND id = 0"

    name = params.fetch("name", "")
    max_occupancy = params.fetch("max_occupancy", "").empty? ? "0" : params["max_occupancy"]
    room_number = params.fetch("room_number", "").empty? ? "%%" : params["room_number"]
    available = params.fetch("available", "false")
    location = params.fetch("location", "").empty? ? "%%" : params["location"]

    where_query = "lower(name) LIKE lower('%#{name}%') AND
                   max_occupancy > #{max_occupancy} AND
                   CAST(room_number AS TEXT) LIKE '#{room_number}' AND
                   available = #{available} AND
                   lower(location) LIKE lower('#{location}')" +
                   company_id_query

    Room.where(where_query)
  end

  def self.sort_with(params)
    sort_by = params.fetch("sort_by", "created_at||").split("||")
    sort_dir = params.fetch("sort_dir", "ASC||").split("||")
    sort_hash = Hash[sort_by.zip(sort_dir)]

    order_query = sort_hash.map { |sort_by, sort_dir| "#{sort_by} #{sort_dir}" }.join(", ")
    self.order(order_query)
  end

  def update_time_sensitive_values
    hours_until_next_meeting = self.meetings.where("start_time > '#{Time.now}'").minimum(:start_time) || 1.hour.ago
    hours_until_next_meeting = ((hours_until_next_meeting - Time.now) / 3600).round
    available = self.meetings.where("start_time < '#{Time.now}' AND end_time > '#{Time.now}'").none?

    self.update(hours_until_next_meeting: hours_until_next_meeting, available: available)
  end
end
