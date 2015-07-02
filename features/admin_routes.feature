Feature:
  As a developer I have many admin paths that should only be accessible by
    an employee who is an admin

  Background:
    Given I need to register
    When I sign up

  Scenario: Routing to admin dashboard as non-admin
    And I navigate to "/admin/dashboard"
    Then I should be on the root_path

  Scenario: Routing to admin meeting reports as non-admin
    And I navigate to "/admin/reports_meetings"
    Then I should be on the root_path

  Scenario: Routing to admin room reports as non-admin
    And I navigate to "/admin/reports_rooms"
    Then I should be on the root_path

  Scenario: Routing to admin busiest_employees as non-admin
    And I navigate to "/admin/busiest_employees"
    Then I should be on the root_path

  Scenario: Routing to admin branding as non-admin
    And  I navigate to "/admin/add_branding"
    Then I should be on the root_path

######### checking if logged in as admin

  Scenario: Routing to admin dashboard as admin
    And I am an admin
    And I navigate to "/admin/dashboard"
    Then I should be on "/admin/dashboard"

  Scenario: Routing to admin meeting reports as admin
    And I am an admin
    And I navigate to "/admin/reports_meetings"
    Then I should be on "/admin/reports_meetings"

  Scenario: Routing to admin room reports as admin
    And I am an admin
    And I navigate to "/admin/reports_rooms"
    Then I should be on "/admin/reports_rooms"

  Scenario: Routing to admin busiest_employees as admin
    And I am an admin
    And I navigate to "/admin/busiest_employees"
    Then I should be on "/admin/busiest_employees"

  Scenario: Routing to admin branding as admin
    And I am an admin
    And  I navigate to "/admin/add_branding"
    Then I should be on "/admin/add_branding"


