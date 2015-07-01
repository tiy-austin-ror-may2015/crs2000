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

require 'test_helper'

class RoomTest < ActiveSupport::TestCase

  test "company_rooms returns all the companies" do
    company = Company.create!(name: 'katas')
    company_id = company.id
    foo_room   = Room.create!(name: 'foobar',   company_id: company_id, max_occupancy: 10, location: 'florida')
    fizz_room  = Room.create!(name: 'fizzbuzz', company_id: company_id, max_occupancy: 10, location: 'florida')
    expected   = [
      ['foobar',   foo_room.id],
      ['fizzbuzz', fizz_room.id]
    ]
    actual = Room.company_rooms(company_id)
    assert_equal expected, actual
  end
end
