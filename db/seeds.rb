image =
["http://www.coolbusinessideas.com/wp-content/uploads/2014/05/modern-meeting-room.jpg",
 "http://montvilleoffice.com/wp-content/uploads/2014/07/169979447_conference-room.jpg",
 "http://www.download3dhouse.com/wp-content/uploads/2013/10/Interior-design-meeting-room-3D-view.jpg",
 "http://cdn.home-designing.com/wp-content/uploads/2009/06/creative-light-meeting-room.jpg",
 "https://www.pbcenters.com/sites/default/files/styles/offer_page_image/public/product/product_image_8.jpg",
 "http://www.avautomation.com/wp-content/uploads/2012/07/hotel-meeting-room-design.jpg",
 "http://letthedominoesfall.com/wp-content/uploads/2015/05/conference-room-decorating-how-to-make-meeting-room-design-interior-be-better2.jpg",
 "http://cdn.photolabels.co/images/cdn.home-designing.com/wp-content/uploads/2009/06/futuristic-meeting-room.jpg",
 "http://www.download3dhouse.com/wp-content/uploads/2013/11/Cabin-style-conference-room-interior-design-image.jpg",
 "http://cdn.photolabels.co/images/www.superiorofficeservices.com/images/execconferenceroom.jpg",
 "http://machineoffice.com/wp-content/uploads/2015/01/custom-conference-room-tables-144.jpg",
 "http://blog.davincimeetingrooms.com/wp-content/uploads/2013/03/Meeting-rooms_week-24_2.jpg",
 "http://www.shangri-la.com/uploadedImages/Shangri-la_Hotels/Beijing,_China_World/CWH-Bg-Meetings-Events-Meeting-Classroom-Set-Up.jpg",
 "https://s-media-cache-ak0.pinimg.com/736x/35/aa/5c/35aa5c879d51fba1fca7fd8435761460.jpg",
 "http://static.paradizo.com/albums/large/elysium-resort-spa/elysium-resort-spa-meeting-rooms/elysium-resort-spa-meeting-room-1.jpg",
 "http://azhari.typepad.com/.a/6a0120a6cd4566970b017c38a9059e970b-pi",
 "http://www.bculik.com/wp-content/uploads/2010/05/office-meeting-room-design-03.jpg"]

perks = ['Coffeemaker', 'Courtyard View', 'Kitchenette', "Watercooler", 'Teleconferencing Capable', 'Videoconferencing capable', 'Whiteboard', 'Soundproof', 'Central Location', 'Overhead Projector', 'Donuts', 'Includes Holodeck']
amenities = perks.map { |perk| Amenity.create(perk: perk) }

earliest = 5.hours.ago
latest = 5.hours.from_now


3.times do
  company = Company.create(name: Faker::Company.name)

  possible_room_numbers = (100..399).to_a
  company_room_number = possible_room_numbers.sample(rand(15..50))
  company_room_number.each do |room_number|
    room = Room.create(name: "The #{Faker::Commerce.color.capitalize} Room",
              max_occupancy: rand(1..100),
                room_number: room_number,
                     imgurl: image.sample,
                   location: Faker::App.name, company_id: company.id)

    room_amenities = amenities.sample(rand(4))
    room_amenities.each { |amenity| RoomAmenity.create(room_id: room.id, amenity_id: amenity.id) }
  end

  rand(25..50).times do
    employee = Employee.create(name: Faker::Name.name, email: Faker::Internet.safe_email,
                           password: 'password', password_confirmation: 'password',
                         company_id: company.id)

    rand(3).times do
      rand_duration = rand(15..45).minutes
      rand_start_time = Time.at((latest.to_f - earliest.to_f)*rand + earliest.to_f)
      rand_end_time = rand_start_time + rand_duration

      meeting_room = Room.all.sample
      meeting_room = Room.all.sample until meeting_room.is_available?(rand_start_time + rand_duration / 2)
      meeting = Meeting.create(title: Faker::Company.bs, agenda: Faker::Lorem.paragraph,
                          start_time: rand_start_time,
                            end_time: rand_end_time,
                             private: ([true] + [false] * 5).sample,
                             room_id: meeting_room.id,
                         employee_id: employee.id)

      invited_employees = Employee.where.not(id: employee.id).sample(rand(20))
      max_attendees = meeting_room.max_occupancy - 1
      max_attendees = max_attendees < invited_employees.size ? max_attendees : invited_employees.size
      attending_employees = invited_employees.sample(max_attendees)

      invited_employees.each do |employee|
        meeting.invitations.create(employee_id: employee.id)
      end

      attending_employees.each do |employee|
        meeting.employee_meetings.create(employee_id: employee.id)
      end
    end
  end
end

Employee.create!(name: 'example user', email: 'user@example.com', password: 'password', password_confirmation: 'password', company_id: Company.first.id, admin: false)
Employee.create!(name: 'example admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', company_id: Company.first.id, admin: true)
