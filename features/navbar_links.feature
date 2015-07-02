Feature:
  As a employee I want to be able to navigate the app using the links
    in the navigation bar

  Background:
    Given I have an account
    When I login

  Scenario: I click on new meetings
    And I click "new_meeting"
    Then I should be on the "/meetings/new"


