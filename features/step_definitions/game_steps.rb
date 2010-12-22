Given /^I am a registered Facebook user$/ do
  @current_user = Factory(:user)
end

When /^I login with valid credentials$/ do
  Facebooker2.load_facebooker_yaml
  When "I go to the login page"
  fill_in('Email', :with => @current_user.email)
  click_button("Log Me In")
end

Then /^I should see my name$/ do
  name = @current_user.name
  Then "I should see \"#{name}\""
end

Then /^I should see my name within "([^"]*)"$/ do |tag_type|
  name = @current_user.name
  Then "I should see \"#{name}\" within \"#{tag_type}\""
end
