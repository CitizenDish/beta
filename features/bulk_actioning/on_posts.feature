Feature: Bulk Edit Posts
  In order for editors to be most efficient
  An editor
  Should be able to perform actions on multiple posts


    Scenario: Editor selects positive sentiment action
      Given A non-empty collection of posts
      When I click on the positive sentiment icon
      Then Each post in the collection will be updated with
