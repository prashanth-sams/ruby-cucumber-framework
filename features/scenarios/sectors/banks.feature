Feature: Argaam - Sectors

  # Sector section - Banks Page

  @sectors @banks
  Scenario: Verify banks page
    Given I navigate to "sectors banks" page
    Then I verify the sectors "banks" page
