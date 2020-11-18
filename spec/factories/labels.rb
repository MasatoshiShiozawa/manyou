FactoryBot.define do

  factory :label do
    name { "あ" }
  end

  factory :second_label, class: Label do
    name { "い" }
  end

  factory :third_label, class: Label do
    name { "う" }
  end

  factory :fourth_label, class: Label do
    name { "え" }
  end

end
