Given /^I am a registered Facebook user with name "([^\"]*)"$/ do |fb_user_name|
  @current_user = Factory(:user, :name => fb_user_name)
end

When /^I login with valid credentials$/ do
  Facebooker2.load_facebooker_yaml
  When "I go to the login page"
  fill_in('email', :with => @current_user.email)
  click_button("Log Me In")
end

When /^I create a new Setsolver game$/ do
  When "I login with valid credentials"
  When "I go to the new game page"
  When "I press \"Create New Game\""
  When "I go to the list of games"
  @current_game = @current_user.player.games.first
end

When /^I select three cards that are a Set$/ do
  # iterate on cards within first set returned in array; there should always be at least one set in the field.
  card_positions = @current_game.find_set_card_positions[0]
  When "I select three cards at positions #{card_positions[0]}, #{card_positions[1]}, and #{card_positions[2]}"
  When "I press \"Submit Three Card Set\""
end

When /^I select three cards that are not a Set$/ do
  nonset_combination = Game.each_cmb3(12).find do |combination|
    cards = combination.map {|indx| @current_game.field[indx] }
    cards if !(@current_game.is_set? *cards)
  end
  nonset_combination_cards = nonset_combination.map {|indx| @current_game.field[indx] }
  When "I select three cards at positions #{nonset_combination[0]}, #{nonset_combination[1]}, and #{nonset_combination[2]}"
  When "I press \"Submit Three Card Set\""
end

When /^I select three cards at positions ([0-9]+), ([0-9]+), and ([0-9]+)$/ do |pos1, pos2, pos3|
  [pos1, pos2, pos3].each do |indx|
    check(field_with_id("card#{indx}"))
  end
end

Then /^I should see my name$/ do
  Then "I should see \"#{@current_user.name}\""
end

Then /^I should see my name within "([^\"]*)"$/ do |tag_type|
  Then "I should see \"#{@current_user.name}\" within \"#{tag_type}\""
end

Then /^I should see a game field with at least ([0-9]+) unselected Set cards$/ do |number_of_cards|
  0.upto(number_of_cards.to_i - 1) do |card_number|
    checkbox_id = "card#{card_number}"
    field_with_id(checkbox_id).should_not be_checked
  end
end
