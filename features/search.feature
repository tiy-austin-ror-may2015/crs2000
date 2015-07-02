Feature:
  As an employee I should be able to search for things I am looking for
    and have results displayed if any found

  Background:
    Given I have an account
    When I login

  Scenario: I visit the employees page and search
    And I navigate to "/employees"
    And I search for "frank"
    Then I should see "Frank"

  Scenario: I visit the meetings page and search
    And I navigate to "/meetings"
    And I search for "synergy"
    Then I should see "Synergy"

  # Cannot be used until one search bar on rooms page.
  # Scenario: I visit the rooms page and search
  #   And I navigate to "/rooms"
  #   And I search for "lavender"
  #   Then I should see "Lavender"
