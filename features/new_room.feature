Feature:
  As an admin, and only as an admin, I should be able to create a new room

  Background:
    Given I have an account
    When I login

  Scenario: Create a new room as an admin
    And I am an admin
    And I create a new room
    Then I should be on "/rooms/2"

  Scenario: Create a new room not as an admin
    And I navigate to "/rooms/new"
    Then I should be on the root_path

