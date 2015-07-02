When(/^I join a meeting$/) do
  click_on("Join")
end

When(/^a meeting exists$/) do
  employee = Employee.create!(name: 'frank', email: 'frank@joe.com',
                         password: 'password',
            password_confirmation: 'password', company_id: @company.id)
  room = Room.create!(name: 'blue test room', max_occupancy: 40,
              room_number: 305, location: 'frank')
  meeting = Meeting.create!(title: 'test_join', agenda: 'success',
                      start_time: '2016-07-02 20:18:41',
                        end_time: '2016-07-02 20:18:41',
                     employee_id: employee.id, room_id: room.id)

end

When(/^I join the meeting$/) do
  visit "/meetings/#{Meeting.last.id}"
  click_on("Join")
end

