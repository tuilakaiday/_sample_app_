User.create!(name: "Kai Admin",
              email: "kai.jsone@gmail.com",
              password: "111111",
              password_confirmation: "111111",
              admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password)
end
