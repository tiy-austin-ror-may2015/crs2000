Feature:
  As a developer I would like to verify unauthorized users
    can only access the Sign Up and Log In pages

  Background:
    Given I need to register

  Scenario: Clicking on all rooms link while not logged in
    When I navigate to "/rooms"
    Then I should be on the "/employees/sign_in"

  Scenario: Clicking on all meetings link while not logged in
    When I navigate to "/meetings"
    Then I should be on the "/employees/sign_in"

  Scenario: Clicking on all employees link while not logged in
    When I navigate to "/employees"
    Then I should be on the "/employees/sign_in"
