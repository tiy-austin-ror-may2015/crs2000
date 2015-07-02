When(/^I create a meeting$/) do
  Room.create!(name: "the test room", location: 'the moon',
                  company_id: @company.id, max_occupancy: 40)
  visit '/meetings/new'
  fill_in 'meeting_title', with: 'test meeting'
  fill_in 'meeting_agenda', with: 'blah blah do this do that agenda'
  fill_in 'meeting_start_time', with: '2016/07/09 19:29'
  fill_in 'meeting_end_time', with: '2016/07/10 19:29'
  click_button("Create Meeting")
end

Then(/^I should be on the that meeting's page$/) do
  assert_equal meeting_path(Meeting.last), current_path
end
