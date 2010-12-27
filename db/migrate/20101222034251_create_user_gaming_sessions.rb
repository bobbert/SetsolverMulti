class CreateUserGamingSessions < ActiveRecord::Migration
  def self.up
    create_table :user_gaming_sessions do |t|
      t.integer :user_id
      t.integer :game_id
      t.datetime :last_played_at
      t.float :seconds_from_previous_session
      t.integer :active_game
      t.timestamps
    end
  end

  def self.down
    drop_table :user_active_sessions
  end
end
