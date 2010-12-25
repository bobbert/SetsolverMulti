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
  @current_player = @current_user.player
  @current_game = @current_player.games.first
end

When /^I select three cards that are a Set$/ do
  # iterate on cards within first set returned in array; there should always be at least one set in the field.
  card_positions = @current_game.find_set_card_positions[0]
  When "I select three cards at positions #{card_positions[0]}, #{card_positions[1]}, and #{card_positions[2]} and press Submit"
end

When /^I select three cards that are not a Set$/ do
  nonset_combination = Game.each_cmb3(12).find do |combination|
    cards = combination.map {|indx| @current_game.field[indx] }
    cards if !(@current_game.is_set? *cards)
  end
  nonset_combination_cards = nonset_combination.map {|indx| @current_game.field[indx] }
  When "I select three cards at positions #{nonset_combination[0]}, #{nonset_combination[1]}, and #{nonset_combination[2]} and press Submit"
end

When /^I select three cards at positions ([0-9]+), ([0-9]+), and ([0-9]+) and press Submit$/ do |pos1, pos2, pos3|
  [pos1, pos2, pos3].each do |indx|
    check(field_with_id("card#{indx}"))
  end
  When "I press \"Submit Three Card Set\""
  [@current_user,@current_player,@current_game].each &:reload
end

When /^I play through an entire Set game$/ do
  num_sets_found = @current_player.threecardsets.length
  until @current_game.finished?
    When "I select three cards that are a Set"
    unless (@current_player.threecardsets.length == num_sets_found + 1) 
      raise "The number of Sets found did not increase by one. (sets found previously=#{num_sets_found}, now=#{@current_player.threecardsets.length})" 
    end
    num_sets_found = @current_player.threecardsets.length
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

Then /^my score should be ([0-9]+)$/ do |score|
  @current_player.score(@current_game).points.should == score.to_i
end

Then /^my score should be between ([0-9]+) and ([0-9]+)$/ do |low_score, high_score|
  @current_player.score(@current_game).points.should >= low_score.to_i
  @current_player.score(@current_game).points.should <= high_score.to_i
end


