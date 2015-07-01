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
