Feature:
  As a employee I want to be able to navigate the app using the links
    in the navigation bar

  Background:
    Given I have an account
    When I login

  Scenario: I click on new meetings
    And I click "new_meeting"
    Then I should be on the "/meetings/new"

  Scenario: I click on all meetings
    And I click "All Meetings"
    Then I should be on the "/meetings"

  Scenario: I click on all rooms
    And I click "All Rooms"
    Then I should be on the "/rooms"

  Scenario: I click on all employees
    And I click "All Employees"
    Then I should be on the "/employees"

  Scenario: I click on my profile link
    And I click "Logged in as: foobar"
    Then I should be on my profile page

