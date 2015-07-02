When(/^I create a new room$/) do
  visit '/rooms/new'
  fill_in 'room_name', with: 'test_room'
  fill_in 'room_max_occupancy', with: 20
  fill_in 'room_room_number', with: 305
  fill_in 'room_imgurl', with: 'http://cdn1.medicalnewstoday.com/content/images/articles/283/283006/cucumber.jpg'
  fill_in 'room_location', with: 'cucumber land'
  click_button("Create Room")
end
