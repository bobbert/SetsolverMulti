Feature: Manage Games
  In order to create Setsolver games to play
  As a Facebook user playing the Setsolver game application
  I want to create and manage new games

  Scenario: Successful Login
    Given I am logged in as a Facebook user
    When I go to the list of games
    Then I should see my name