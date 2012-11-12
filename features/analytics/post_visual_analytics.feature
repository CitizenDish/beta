Feature: Post Visual Analytics
  In order to better digest information
  The post data source
  Should be visualized

  Scenario: Current month post data, by channel
    Given Proper authentication is met
    When I submit my query
    And Query contains date constraint for current month
    And Query contains channel grouping
    Then I should receive a successful result set

  Scenario: Current month post data, by client
    Given Proper authentication is met
    When I submit my query
    And Query contains date constraint for current month
    And Query contains client grouping
    Then I should receive a successful result set

  Scenario: Current month twitter data, by client
    Given Proper authentication is met
    When I submit my query
    And Query contains date constraint for current month
    And Query contains twitter grouping
    And Query contains client grouping
    Then I should receive a successful result set

  Scenario: Current month facebook data, by client
    Given Proper authentication is met
    When I submit my query
    And Query contains date constraint for current month
    And Query contains facebook grouping
    And Query contains client grouping
    Then I should receive a successful result set

  Scenario: Current month blog data, by client
    Given Proper authentication is met
    When I submit my query
    And Query contains date constraint for current month
    And Query contains blog grouping
    And Query contains client grouping
    Then I should receive a successful result set

  Scenario: Current month customer reviews data, by client
    Given Proper authentication is met
    When I submit my query
    And Query contains date constraint for current month
    And Query contains blog grouping
    And Query contains client grouping
    Then I should receive a successful result set

