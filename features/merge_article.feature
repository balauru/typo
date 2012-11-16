Feature: Merge article
  As an admin
  In order to keep things clean
  I will like to be able to merge articles

Background:
  Given the blog is set up
  And there is a publisher "pub1"
  And there is a publisher "pub2"
  And there is article published by "pub1" with title "Some interesting title"
  And there is article published by "pub2" with title "Some other interesting title"

Scenario: A non-admin cannot merge articles
  Given I am logged into the admin panel as "pub1"
  And I go to edit article with title "Some interesting title"
  Then I should not see "Merge Articles"

Scenario: Merge article text
  Given I am logged into the admin panel
  And I go to edit article with title "Some other interesting title"
  When I fill in "merge_with" with the id of "Some interesting title"
  And I press "Merge"
  Then a merge article should be created