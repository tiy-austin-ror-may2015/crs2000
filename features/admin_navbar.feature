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
