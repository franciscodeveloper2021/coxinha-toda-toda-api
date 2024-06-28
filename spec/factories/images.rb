FactoryBot.define do
  factory :image do
    description { Faker::Lorem.paragraph }
    content { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test.png'), 'image/png') }
    imageable { nil }
  end
end
