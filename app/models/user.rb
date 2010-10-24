class User < ActiveRecord::Base
  has_one :player
  after_create :new_player

  validates_presence_of :email
  validates_uniqueness_of :email
  
  def connected?
    !facebook_id.blank?
  end
  
  # create new Player object immediately after creating user
  def new_player
    self.player = Player.new
  end
  
end

