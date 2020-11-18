10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: false)
end
# User.create!(name:  "管理者3",
#              email: "suzukiadmin3@example.jp",
#              password:  "suzuki",
#              password_confirmation: "suzuki",
#              admin: true)

Label.create!(
  name: 'あ'
)

Label.create!(
  name: 'い'
)

Label.create!(
  name: 'う'
)

Label.create!(
  name: 'え'
)

Label.create!(
  name: 'お'
)

Label.create!(
  name: 'か'
)

Label.create!(
  name: 'き'
)

Label.create!(
  name: 'く'
)

Label.create!(
  name: 'け'
)

Label.create!(
  name: 'こ'
)

20.times do |n|
  title = Faker::JapaneseMedia::Doraemon.character
  content = Faker::JapaneseMedia::DragonBall.race
  date = Faker::Date.between(from: Date.tomorrow, to: 30.days.since)
  status = ["未着手","進行中","完了"]
  Task.create!(title: title,
              content: content,
              deadline: date,
              status: status.sample,
              priority: rand(0..2),
              user_id: rand(1..11))
end
