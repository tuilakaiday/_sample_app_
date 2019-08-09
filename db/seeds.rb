User.create!(name: "Kai Admin",
              email: "kai.jsone@gmail.com",
              password: "111111",
              password_confirmation: "111111",
              admin: true,
              activated: true,
              activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "ex-#{n+1}@gmail.com"
  password = "111111"
  User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password,
                activated: false,
                activated_at: Time.zone.now)
end
