Feature: Manage Games
  In order to create Setsolver games to play
  As a Facebook user playing the Setsolver game application
  I want to create and manage new games

  Scenario: Successful Login
    Given I am a registered Facebook user
    When I login with valid credentials
    And I go to the list of games
    Then I should see my name