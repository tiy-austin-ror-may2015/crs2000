# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



50.times do
  company = Company.create(name: Faker::Company.name)
  room = Room.create(name: Faker::Name.last_name, max_occupancy: Faker::Number.number(2),
              room_number: rand(200..400),
              # feel free to delete the amenities thing if you want
                # amenities: ["overhead projector", "teleconferencing capable", "hologram conferencing capable", "coffee maker", "videoconferencing capable", "soundproof", "whiteboard"].sample(rand(1..3)).join(", "),
                   imgurl: "http://cdn.home-designing.com/wp-content/uploads/2009/06/large-meeting-room.jpg",
                 location: Faker::App.name, company_id: company.id)

  employee = Employee.create(name: Faker::Name.name, email: Faker::Internet.safe_email,
                         password: 'password', password_confirmation: 'password',
                       company_id: company.id)
  meeting = Meeting.create(title: Faker::Company.bs, agenda: Faker::Lorem.paragraph,
                      start_time: (Time.now + 10.hours),
                        end_time: (Time.now + 15.hours),
                         room_id: room.id, employee_id: employee.id)
  employee_meeting = EmployeeMeeting.create(enrolled: Faker::Number.digit,
                                         employee_id: employee.id,
                                         meeting_id: meeting.id)
end
