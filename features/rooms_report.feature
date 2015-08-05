Feature:
  As an admin i navigate to the rooms report and i utilize the features on this page

  Background:
    Given I need to register
    And I sign up
    When I am an admin
    And I create a new room
    And I click "Rooms Report"

  Scenario: I click on see image in the top rooms section
    And I click "click to see image"
    Then I should see "meeting room view"

  Scenario:
