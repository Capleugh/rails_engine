FactoryBot.define do
  factory :merchant do
    name { Faker::TvShows::BojackHorseman.character }
    created_at { Faker::Time.backward(days: 25, period: :morning, format: :short) }
    updated_at { Faker::Time.backward(days: 10, period: :morning, format: :short) }
  end
end
