FactoryBot.define do
  factory :sector do
    name { Faker::Lorem.characters(number: 5) }
  end
end
