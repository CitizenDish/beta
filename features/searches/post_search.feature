Feature: Post Search
  In order for editors to organize their workflow
  An editor
  Should be able to create arbitrary queries

    Scenario: Editor enters no constraints
      Given Proper authentication is met
      And Query is empty
      When I submit my query
      Then A default query criteria will be used
      And I should receive a successful result set
      And Editors last query will be cached

    Scenario: Editor enters date range constraint
      Given Proper authentication is met
      And Query contains date range constraint
      When I submit my query
      Then A proper query criteria object will be used
      And I should receive a successful result set
      And Editors last query will be cached

    Scenario: Editor enters multiple constraints
      Given Proper authentication is met
      And Query contains multiple constraints
      When I submit my query
      Then A proper query criteria object will be used
      And I should receive a successful result set
      And Editors last query will be cached
