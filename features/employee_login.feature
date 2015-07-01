Feature:
  As an employee I would like to login to the application

  Scenario: Logging in to the application as an employee with an account
    Given I have an account
    When I login
    Then I should be on the "/"

  Scenario: Logging out of application
    Given I have an account
    When I login
    And I click "Log Out"
    Then I should be on the "/"

  Scenario: Going to Meetings index
    Given I have an account
    When I login
    And I click "All Meetings"
    Then I should be on the "/meetings"
