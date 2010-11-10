class User < ActiveRecord::Base
  has_one :player
  after_create :new_player

  has_many :friend_relationships, :dependent => :destroy
  has_many :friends, :through => :friend_relationships, :source => :friend

  validates_presence_of :email
  validates_uniqueness_of :email
  
  # adds new Facebook friends to friend_relationships association
  def add_new_fb_friends(fb_friends)
    fb_new_friends_with_app = get_new_fb_friends_from_list(fb_friends)
    fb_new_friends_with_app.each do |fb_friend|
      self.friends << fb_friend
    end
    self.save! && fb_new_friends_with_app
  end  
  
  def get_new_fb_friends_from_list(fb_friends)
    fb_friend_ids = (fb_friends.map &:id) 
    new_fb_friend_ids_with_app = (fb_friend_ids & (User.find(:all).map &:facebook_id)) - (self.friends.map &:facebook_id)
    return new_fb_friend_ids_with_app.map {|fb_id| User.find_by_facebook_id fb_id }
  end
  
  def connected?
    !facebook_id.blank?
  end
  
  # create new Player object immediately after creating user
  def new_player
    self.player = Player.new
  end
  
  # get Mogli user object for accessing Facebook data
  def get_mogli_user
    Mogli::User.find(self.facebook_id)
  end
  
  MogliMethods = [:image_url]
  
  # create local wrapper methods for Mogli method calls -- RWP: create 1-arg methods that take user object
  MogliMethods.each do |mogli_method_name|
    define_method(mogli_method_name) do 
      get_mogli_user.send(mogli_method_name)
    end    
  end
  
end

