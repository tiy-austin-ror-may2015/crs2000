50.times do
  company = Company.create(name: Faker::Company.name)
  room = Room.create(name: Faker::Name.last_name, max_occupancy: Faker::Number.number(2),
              room_number: Faker::PhoneNumber.area_code,
                   imgurl: "http://cdn.home-designing.com/wp-content/uploads/2009/06/large-meeting-room.jpg",
                 location: Faker::App.name, company_id: company.id)
  password = Faker::Internet.password
  employee = Employee.create(name: Faker::Name.name, email: Faker::Internet.safe_email,
                         password: password, password_confirmation: password,
                       company_id: company.id)
  meeting = Meeting.create(title: Faker::Company.bs, agenda: Faker::Lorem.paragraph,
                      start_time: (Time.now + 10.hours),
                        end_time: (Time.now + 15.hours),
                         room_id: room.id, employee_id: employee.id)
  employee_meeting = EmployeeMeeting.create(enrolled: Faker::Number.digit,
                                         employee_id: employee.id,
                                         meetings_id: meeting.id)
end
