Feature: Post Search
  In order for editors to organize their workflow
  An editor
  Should be able to create arbitrary queries on post data

    Scenario: Editor enters no constraints
      Given Proper authentication is met
      And Query is empty
      When I submit my query
      Then A default query criteria will be used
      And I should receive a successful result set
      And Editors last query will be cached

    Scenario: Editor enters date range constraint
      Given Proper authentication is met
      And Query contains date constraint
      When I submit my query
      Then A proper query criteria object will be used
      And I should receive a successful result set
      And Every post in this collection will match date constraints
      And Editors last query will be cached

    Scenario: Editor enters multiple constraints
      Given Proper authentication is met
      And Query contains date constraint
      And Query contains channel constraint
      And Query contains client constraint
      When I submit my query
      Then A proper query criteria object will be used
      And I should receive a successful result set
      And Every post in this collection will match date, channel, and client constraints
      And Editors last query will be cached


    Scenario: Editor submits any query
      Given Proper authentication is met
      And Query is valid
      When I submit my query
      Then A proper query criteria object will be used
      And I should receive a successful result set
      And I should have an option to bulk edit result set