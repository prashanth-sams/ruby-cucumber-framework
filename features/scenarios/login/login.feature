Feature: Argaam - User Authentication

  # Validate Credentials

  @login
  Scenario: User Authentication
    Given I navigate to "home" page
    Then I verify the home page as "bob" user
    When I login as a real user
    Then I verify the home page as "real" user
