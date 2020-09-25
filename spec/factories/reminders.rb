FactoryBot.define do
  factory :reminder do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(digits: 10) }
    done { false }
  end
end