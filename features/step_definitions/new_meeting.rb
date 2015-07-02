When(/^I create a meeting$/) do
  Meeting.create(title: 'test', agenda: 'test',
            start_time: '2016/07/09 19:29', end_time: '2016/07/09 19:29')
  Room.create(name: "the test room")
  visit '/meetings/new'
  fill_in 'meeting_title', with: 'test meeting'
  fill_in 'meeting_agenda', with: 'blah blah do this do that agenda'
  fill_in 'meeting_start_time', with: '2016/07/09 19:29'
  fill_in 'meeting_end_time', with: '2016/07/10 19:29'
  click_button("Create Meeting")
end
