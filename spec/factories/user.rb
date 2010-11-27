# User factories
Factory.define :user do |u|
  u.facebook_id      1
  u.name             "Test User1"
  u.email            "user1@test.com"
end

Factory.define :user2 do |u|
  u.facebook_id      2
  u.name             "Test User2"
  u.email            "user2@test.com"
end

