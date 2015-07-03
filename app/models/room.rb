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
      "next_meeting" => nil
    }
    return next_meeting_details if self.meetings.none?

    now = Time.now
    next_earliest_start_time = self.meetings.first.start_time
    self.meetings.each do |meeting|
      start_time = meeting.start_time
      if start_time <= now && meeting.end_time >= now
        next_meeting_details["available"] = "no"
      end
      if start_time > now && start_time <= next_earliest_start_time
        next_earliest_start_time = start_time
        next_meeting_details["start_time"] = next_earliest_start_time
        next_meeting_details["next_meeting"] = meeting
      end
    end
    next_meeting_details
  end
end
