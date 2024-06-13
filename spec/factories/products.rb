FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price(range: 0.0..1000.0) }
    available { true }
    association :sector, factory: :sector
  end
end
