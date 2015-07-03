Feature:
  As an admin I want to be able to navigate the app using the links
    in the admin navigation bar

  Background:
    Given I need to register
    When I sign up
    And I am an admin
    And I navigate to "/"

  Scenario: I click on admin dashboard
    And I click "Admin Dashboard"
    Then I should be on the "/admin/dashboard"

  Scenario: I click on create a room
    And I click "Create a Room"
    Then I should be on the "/rooms/new"

  Scenario: I click on meetings report
    And I click "Meetings Report"
    Then I should be on the "/admin/reports_meetings"

  Scenario: I click on rooms report
    And I click "Rooms Report"
    Then I should be on the "/admin/reports_rooms"

  Scenario: I click on employee report
    And I click "Employee Report"
    Then I should be on the "/admin/busiest_employees"

  Scenario: I click on branding
    And I click "Branding"
    Then I should be on the "/admin/add_branding"

# Wont work until cecycs branch gets merged in with new routes
  # Scenario: I click on meeting invites
  #   And I click "Meeting invites"
  #   Then I should be on the "/admin/invitations/show"
