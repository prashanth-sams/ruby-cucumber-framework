Feature: Google search

  @login
  Scenario Outline: Google search test
    Given I navigate to Google page
    Then I verify the goole home page
    When I search for keyword "<Search>"
    Then I verify the search result
    Examples:
      | Search              |
      | Prashanth Sams      |
      | Selenium Essentials |