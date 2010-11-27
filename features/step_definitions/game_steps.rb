

Given /^I am logged in as a Facebook user$/ do
  
  # Initializer facebooker session
  @session = open_session
  
  @current_user = User.create! :facebook_id => 1, :name => 'Joe', :email => 'joe@test.com'

  # User#facebook_user returns a Facebook::User instance, i decided to mock the session in here since i am not
  # sure what the behavior might be if it will be in the actual model.
  @current_user.fb_user.session = Facebooker::MockSession.create(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_SECRET_KEY'])
  @current_user.fb_user.friends = [ Facebooker::User.new(:id => 2, :name => 'Bob', :email => 'bob@test.com'),
    Facebooker::User.new(:id => 3, :name => 'Sam', :email => 'sam@test.com')]
  @session.default_request_params.merge!( :fb_sig_user => @current_user.facebook_id )
#  @session.default_request_params.merge!( :fb_sig_user => @current_user.facebook_id, :fb_sig_friends => @current_user.fb_user.friends.map(&:id).join(',') )
end

Then /^I should see my name$/ do
  name = @current_user.name
  Then "I should see \"#{name}\""
end

Then /^I should see my name within "([^"]*)"$/ do |tag_type|
  name = @current_user.name
  Then "I should see \"#{name}\" within \"#{tag_type}\""
end
