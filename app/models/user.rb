class User < ActiveRecord::Base
  has_one :player
  after_create :new_player

  validates_presence_of :email
  validates_uniqueness_of :email
  
  
  # returns a list of all Facebook friends found in database
  def self.fb_friends_with_app_installed(fb_friends)
    fb_friend_ids = fb_friends.map {|f| f.id }
    fb_friend_with_app_ids = fb_friend_ids & User.find(:all).map {|u| u.facebook_id }
    return fb_friend_with_app_ids.map {|f_id| User.find_by_facebook_id(f_id) }
  end  
  
  def connected?
    !facebook_id.blank?
  end
  
  # create new Player object immediately after creating user
  def new_player
    self.player = Player.new
  end
  
end

