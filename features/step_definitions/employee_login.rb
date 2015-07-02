Given(/^I have an account$/) do
  @company = Company.create(name: 'fooo inc')
  @employee = Employee.create!(name: 'foobar', email: 'user@example.com',
                                 password: 'password',
                              password_confirmation: 'password',
                              company_id: @company.id)
end

When(/^I login$/) do
  visit '/employees/sign_in'
  fill_in 'employee_email', with: @employee.email
  fill_in 'employee_password', with: "password"
  click_button("Log in")
end

When(/^I click "(.*?)"$/) do |link_name|
  click_on link_name
end

Then(/^I should be on the "(.*?)"$/) do |path|
  assert_equal path, current_path
end
