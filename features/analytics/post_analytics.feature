Feature: Post Analytics
  In order to better digest information
  The post data source
  Should be visualized

  Scenario: All current month post data, by channel
    Given Proper authentication is met
    When I submit my query
    And Query contains channel constraint
    Then I should receive a successful result set

