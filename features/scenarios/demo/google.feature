Feature: Google search

  @login
  Scenario Outline: Google search test
    Given I navigate to Google home page
    Then I verify the Google home page
    When I search for keyword "<Search>"
    Then I verify the search result
    Examples:
      | Search              |
      | Prashanth Sams      |
      | Selenium Essentials |