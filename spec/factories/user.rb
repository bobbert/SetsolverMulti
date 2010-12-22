# User factories

Factory.define :user do |u|
  u.facebook_id      100001807764056
  u.name             "Bobbert Phelps"
  u.email            "user1@test.com"
end

Factory.define :user2, :class => :user do |u|
  u.facebook_id      793111843
  u.name             "Robert Phelps"
  u.email            "user2@test.com"
end

