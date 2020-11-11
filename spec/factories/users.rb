FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'suzuki_test01' }
    email { 'suzuki_test01@example.com' }
    password { 'suzuki' }
    admin { false }
  end
  factory :second_user, class: User do
    id { 2 }
    name { 'suzuki_test51' }
    email { 'suzuki_test51@example.com' }
    password { 'suzuki' }
    admin { true }
  end
end
