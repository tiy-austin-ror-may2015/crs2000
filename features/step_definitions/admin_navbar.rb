When(/^I click on "(.*?)"$/) do |id|
  find_link(id).click
end

