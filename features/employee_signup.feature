Feature:
  As an employee I would like to signup to the application

  Scenario: Logging in to the application as an employee without an account
    Given I need to register
    When I sign up
    Then I should be on "/"

