Given(/^I need to register$/) do
  Company.create(name: 'joe steel inc')
end

When(/^I sign up$/) do
  visit '/employees/sign_up'
  fill_in 'employee_name', with: 'joe joe'
  fill_in 'employee_email', with: 'joe@joe.com'
  fill_in 'employee_password', with: 'password'
  fill_in 'employee_password_confirmation', with: 'password'
  click_button("Sign Up")
end

Then(/^I should be on "(.*?)"$/) do |path|
  assert_equal current_path, path
end

