# 50.times do |n|
#   name = Faker::Games::Pokemon.name
#   email = Faker::Internet.email
#   password = "password"
#   User.create!(name: name,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                )
# end
User.create!(name:  "管理者3",
             email: "suzukiadmin3@example.jp",
             password:  "suzuki",
             password_confirmation: "suzuki",
             admin: true)
