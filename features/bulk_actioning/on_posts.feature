Feature: Bulk Edit Posts
  In order for editors to be most efficient
  An editor
  Should be able to perform actions on multiple posts

  Scenario: Editor selects positive sentiment action
    Given A non-empty collection of posts
    When I click on the positive sentiment icon
    Then Each post sentiment in the collection will be updated to positive
    And Will receive a success message

  Scenario: Editor selects neutral sentiment action
    Given A non-empty collection of posts
    When I click on the neutral sentiment icon
    Then Each post sentiment in the collection will be updated to neutral
    And Will receive a success message

  Scenario: Editor selects negative sentiment action
    Given A non-empty collection of posts
    When I click on the negative sentiment icon
    Then Each post sentiment in the collection will be updated to negative
    And Will receive a success message

  Scenario: Editor selects any classification rule
    Given A non-empty collection of posts
    When I click on the rule option
    Then Each post classification_rule in the collection will be updated to rule
    And Will receive a success message

  Scenario: Editor selects junk action
    Given A non-empty collection of posts
    When I click on the junk icon
    Then Each post status in the collection will be updated to junk
    And Will receive a success message

  Scenario: Editor selects faulty action
    Given A non-empty collection of posts
    When I click on the faulty icon
    Then Each post status in the collection will be updated to faulty
    And Will receive a success message

  Scenario: Editor selects duplicate action
    Given A non-empty collection of posts
    When I click on the duplication icon
    Then Each post status in the collection will be updated to duplicate
    And Will receive a success message

