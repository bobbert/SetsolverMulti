# UserGamingSession factories
Factory.define :user_gaming_session do |ugs|
  ugs.user { User.first }
  ugs.game { Game.first }
  ugs.seconds_from_previous_session 1.0
  ugs.last_played_at { 10.seconds.ago }
end

