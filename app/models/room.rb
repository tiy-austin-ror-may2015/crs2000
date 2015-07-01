# == Schema Information
#
# Table name: rooms
#
#  id                       :integer          not null, primary key
#  name                     :string
#  max_occupancy            :integer
#  room_number              :integer
#  imgurl                   :string
#  location                 :string
#  company_id               :integer
#  meetings_count           :integer          default(0)
#  available                :boolean          default(TRUE)
#  hours_until_next_meeting :integer          default(-1)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Room < ActiveRecord::Base

belongs_to :company
has_many :meetings
has_many :amenities
validates_presence_of :name, :max_occupancy, :location

def self.updated_room(room, params)
  room[:name]          = params[:room][:name]           if params[:room][:name]
  room[:location]      = params[:room][:location]       if params[:room][:location]
  room[:room_number]   = params[:room][:room_number]    if params[:room][:room_number]
  room[:imgurl]        = params[:room][:imgurl]         if params[:room][:imgurl]
  room[:max_occupancy] = params[:room][:max_occupancy]  if params[:room][:max_occupancy]
  room
end
 # def self.any_seats_available_at?(room_id, start_time, end_time)
 #    room          = Room.find(room_id])
 #    room_capacity = room.max_occupancy
 #    all_meetings  = room.meetings  # get meetings
 #    attendants    = @meeting_model.meetings.employee_meetings.enrolled

 #    if room_capacity > attendants ? true : false
 #  end

 # get room user want to look at
 # get the start_time and end_time user wants to look at
 # check if room has meeting during those times
 # if room has no meeting then room is empty
 # if room does have a meeting
 # check the number of attandents and compare to room capacity
 # send true or false

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
    sort_by   = params.fetch("sort_by", "created_at||").split("||")
    sort_dir  = params.fetch("sort_dir", "ASC||").split("||")
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

  def self.search_for(search)
    self.where("lower(name) LIKE ? OR lower(location) LIKE ? OR max_occupancy > ?",
               "%#{search.downcase}%", "%#{search.downcase}%", search.to_i)
  end

end
