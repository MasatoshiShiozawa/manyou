2.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "suzuki"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: true)
end

8.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "suzuki"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: false)
end

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

50.times do |n|
  title = Faker::Games::Pokemon.name
  content = Faker::Games::Pokemon.location
  deadline = Faker::Date.between(from: Date.tomorrow, to: 30.days.since)
  status = ["0","1","2"]
  Task.create!(title: title,
              content: content,
              deadline: date,
              status: rand(0..2),
              priority: rand(0..2),
              user_id: rand(1..20))
end
