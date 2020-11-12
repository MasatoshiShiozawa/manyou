FactoryBot.define do

  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    deadline { DateTime.now }
    status {'完了'}
    priority {'低'}
    association :user
  end

  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    deadline { DateTime.now }
    status {'未着手'}
    priority {'高'}
    association :user
  end
end
