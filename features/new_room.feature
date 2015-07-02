Feature:
  As an admin, and only as an admin, I should be able to create a new room

Scenario: Create a new room not as an admin
  Given I have an account
  When I login
  And I am an admin
  And I create a new room
  Then I should be on "/rooms/2"

