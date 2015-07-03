Feature:
  As an employee, I want to be able to join a meeting

  Background:
    Given I have an account
    When I login

  Scenario: Employee attempts to join meeting a created
    And I create a meeting
    And I join a meeting
    Then I should see "Employee already joined!"

  Scenario: Employee joins a meeting
    And a meeting exists
    And I join the meeting
    Then I should see "Employee successfully joined!"

  Scenario: Employee joins a meeting but is already in a meeting
    And I create a meeting
    And a meeting exists
    And I join a meeting
    Then I should see "You own or are already in another meeting at this time."

