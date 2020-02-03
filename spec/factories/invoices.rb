FactoryBot.define do
  factory :invoice do
    customer { nil }
    merchant { nil }
    status { 0 }
    created_at { Faker::Time.backward(days: 25, period: :morning, format: :short) }
    updated_at { Faker::Time.backward(days: 10, period: :morning, format: :short) }
  end
end
