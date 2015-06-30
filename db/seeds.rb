
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
 "http://www.bculik.com/wp-content/uploads/2010/05/office-meeting-room-design-03.jpg",
 "http://i.ytimg.com/vi/bDUkzYWxR7E/hqdefault.jpg"]

amenities = ['Coffeemaker', 'Courtyard View' 'Kitchenette', "Watercooler", 'Teleconferencing Capable', 'Videoconferencing capable', 'Whiteboard', 'Soundproof', 'Central Location', 'Overhead Projector', 'Donuts', 'Includes Holodeck']

random_start_times = [(Time.now + 10.hours),(Time.now + 11.hours),(Time.now + 12.hours),(Time.now + 13.hours)]
3.times do
  company = Company.create(name: Faker::Company.name)
  50.times do
      employee = Employee.create(name: Faker::Name.name, email: Faker::Internet.safe_email,
                               password: 'password', password_confirmation: 'password',
                             company_id: company.id)

    2.times do
      room = Room.create(name: "The #{Faker::Commerce.color.capitalize} Room", max_occupancy: Faker::Number.number(2),
                  room_number: rand(200..400),
                       imgurl: image.sample,
                     location: Faker::App.name, company_id: company.id)
      amenity = Amenity.create(perk: amenities.sample,
                               room_id: room.id)
        2.times do
          meeting = Meeting.create(title: Faker::Company.bs, agenda: Faker::Lorem.paragraph,
                            start_time: random_start_times.sample,
                             end_time: random_start_times.sample + 4.hours,
                               room_id: room.id, employee_id: employee.id)
          employee_meeting = EmployeeMeeting.create(enrolled: Faker::Number.digit,
                                                 employee_id: employee.id,
                                            meeting_id: meeting.id)
      end
    end
  end
end
