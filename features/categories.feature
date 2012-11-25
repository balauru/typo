Feature: Categories
  As an admin
  In order to keep things organized
  I will like to be able to add new categories

Scenario: Add category
  Given the blog is set up
  And I am logged into the admin panel
  And I am on the categories page
  Then I should see "Categories"
