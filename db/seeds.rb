User.create!(name: "Kai Admin",
              email: "kai.jsone@gmail.com",
              password: "111111",
              password_confirmation: "111111",
              admin: true,
              activated: true,
              activated_at: Time.zone.now)

10.times do | x|
  User.create!(name: "Kai",
              email: "kai#{x}.jsone@gmail.com",
              password: "111111",
              password_confirmation: "111111",
              admin: true,
              activated: true,
              activated_at: Time.zone.now)

end
user = User.first
15.times do |x|
  content = "This is micropost!"
  user.microposts.create(content: content)

  sleep 2
end

