Feature: Manage Games
  In order to create Setsolver games to play
  As a Facebook user playing the Setsolver game application
  I want to create and manage new games

  Background:
    Given I am a registered Facebook user with name "Test User"

  Scenario: Successful Login
    When I login with valid credentials
    And I go to the list of games
    Then I should see my name

  Scenario: Creating a new game
    When I create a new Setsolver game
    Then I should see "Start playing" within "a.mock-fb-button"

  Scenario: Playing a new game
    When I create a new Setsolver game
    And I follow "Start playing!"
    Then I should see my name within "h1"
    And I should see "Game Score" within "div#score_panel h1"
    And I should see "Game Activity" within "div#activity_panel h1"
    And I should see a game field with at least 12 unselected Set cards

  Scenario: Selecting a correct Set
    When I create a new Setsolver game
    And I follow "Start playing!"
    And I select three cards that are a Set
    Then I should see my name within "div#activity_panel ul#set_records li span.setlisting-name"
    And I should see "found a set:" within "div#activity_panel ul#set_records li"
    And I should not see "The three cards you selected are not a set" within "p#notice"
    And I should see a game field with at least 12 unselected Set cards

  Scenario: Selecting an incorrect Set
    When I create a new Setsolver game
    And I follow "Start playing!"
    And I select three cards that are not a Set
    Then I should see "The three cards you selected are not a set" within "p#notice"
    And I should see a game field with at least 12 unselected Set cards
