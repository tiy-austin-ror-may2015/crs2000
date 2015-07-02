When(/^I navigate to "(.*?)"$/) do |route|
  visit route
end

Then(/^I should be on the root_path$/) do
  assert_equal root_path, current_path
end
