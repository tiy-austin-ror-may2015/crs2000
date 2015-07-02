When(/^I am an admin$/) do
  employee = Employee.first
  employee.admin = true
  employee.save!
end
