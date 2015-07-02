Feature:
  As a developer I would like to verify unauthorized users
    can only access the Sign Up and Log In pages

  Background:
    Given I need to register

  Scenario: Routing to all rooms
    When I navigate to "/rooms"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to all meetings
    When I navigate to "/meetings"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to all employees
    When I navigate to "/employees"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to admin dashboard
    When I navigate to "/admin/dashboard"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to admin reports
    When I navigate to "/admin/reports_meetings"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to admin room reports
    When I navigate to "/admin/reports_rooms"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to admin top-room reports
    When I navigate to "/admin/reports_rooms/top_rooms"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to admin busiest_employees
    When I navigate to "/admin/busiest_employees"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to admin branding
    When I navigate to "/admin/add_branding"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to employee show
    When I navigate to "/employees/4"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to employee edit
    When I navigate to "/employees/4/edit"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to employees search
    When I navigate to "/search/employees"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to meetings search
    When I navigate to "/search/meetings"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to rooms search
    When I navigate to "/search/rooms"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to rooms advance search
    When I navigate to "/search_advance/rooms"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to new room
    When I navigate to "/rooms/new"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to edit room
    When I navigate to "/rooms/1/edit"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to show room
    When I navigate to "/rooms/1"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to new company
    When I navigate to "/companies/new"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to edit company
    When I navigate to "/companies/1/edit"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to show company
    When I navigate to "/companies/1"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to new meetings
    When I navigate to "/meetings/new"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to edit meeting
    When I navigate to "/meetings/1/edit"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to show meeting
    When I navigate to "/meetings/1"
    Then I should be on the "/employees/sign_in"

  Scenario: Routing to all meetings
    When I sign up
    And I navigate to "/meetings"
    Then I should be on the "/meetings"

  Scenario: Routing to all rooms
    When I sign up
    And I navigate to "/rooms"
    Then I should be on the "/rooms"

  Scenario: Routing to all employees
    When I sign up
    And I navigate to "/employees"
    Then I should be on the "/employees"
