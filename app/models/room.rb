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
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Room < ActiveRecord::Base

belongs_to :company
has_many :room_amenities
has_many :meetings
has_many :amenities, through: :room_amenities
validates_presence_of :name, :max_occupancy, :location

def self.updated_room(room, params)
  room[:name]          = params[:room][:name]           if params[:room][:name]
  room[:location]      = params[:room][:location]       if params[:room][:location]
  room[:room_number]   = params[:room][:room_number]    if params[:room][:room_number]
  room[:imgurl]        = params[:room][:imgurl]         if params[:room][:imgurl]
  room[:max_occupancy] = params[:room][:max_occupancy]  if params[:room][:max_occupancy]
  room
end

  def self.company_rooms(company)
    self.where(company_id: company).map { |room| [room.name, room.id] }
  end

  def self.search_for(params)
    search = params[:search].downcase
    max_occupancy = params["max_occupancy"].empty? ? "-1" : params["max_occupancy"]
    room_number = params["room_number"].empty? ? "%%" : params["room_number"]

    amenities = Amenity.where("lower(perk) LIKE lower('%#{search}%')")
    room_ids = amenities.map{ |amenity| amenity.rooms.pluck(:id) }.flatten.uniq

    amenity_query = room_ids.map{ |id| "id = #{id}" }.join(" OR ")
    amenity_query.empty? ? amenity_query = " OR id = 0)" : amenity_query.prepend(" OR (") << "))"
    search_query = "max_occupancy >= #{max_occupancy}
                    AND CAST(room_number AS TEXT) LIKE '#{room_number}'
                    AND (lower(name) LIKE '%#{search}%'
                    OR lower(location) LIKE ('%#{search}%')" + amenity_query
    self.where(search_query)
  end

  def get_next_meeting_details
    next_meeting_details = {
      "start_time" => "N/A",
      "available" => "yes",
      "next_meeting" => nil,
      "inv_emp_ids" => []
    }
    return next_meeting_details if self.meetings.none?

    next_meeting_details["available"] = is_available? ? "yes" : "no"
    next_meeting = get_next_meeting
    next_meeting_details["next_meeting"] = next_meeting
    next_meeting_details["start_time"] = next_meeting.nil? ? "N/A" : next_meeting.start_time
    next_meeting_details["inv_emp_ids"] = get_invited_employee_ids(next_meeting)
    next_meeting_details
  end

  def is_available?(at_time = Time.now)
    true
    self.meetings.each do |meeting|
      start_time = meeting.start_time
      return false if start_time <= at_time && meeting.end_time >= at_time
    end
  end

  private

  def get_next_meeting(at_time = Time.now)
    next_meeting = nil
    next_earliest_start_time = self.meetings.first.start_time
    self.meetings.each do |meeting|
      start_time = meeting.start_time
      if start_time > at_time && start_time <= next_earliest_start_time
        next_earliest_start_time = start_time
        next_meeting = meeting
      end
    end
    next_meeting
  end

  def get_invited_employee_ids(next_meeting)
    return [] if next_meeting.none?
    next_meeting.invitations.pluck(:employee_id)
  end
end
