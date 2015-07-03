Then(/^I should be on my profile page$/) do
  assert_equal employee_path(Employee.last), current_path
end
