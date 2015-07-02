When(/^I search for "(.*?)"$/) do |query|
  fill_in 'search', with: query
  click_on('Search')
end

Then(/^I should see "(.*?)"$/) do |query|
  page.has_content?(query)
end
