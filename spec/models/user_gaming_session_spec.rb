require 'spec_helper'

describe UserGamingSession do
  before(:each) do
    # Cardfaces are pre-loaded into the database via fixtures, because they are
    # an essential part of playing the Set game.
    @user_gaming_session = Factory(:user_gaming_session)
  end

  describe 'when a user is not playing a game' do
  end
  

end
