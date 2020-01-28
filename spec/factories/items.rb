FactoryBot.define do
  factory :item do
    name { "Glengoolie Blue" }
    description { "For the best of times." }
    unit_price { 1 }
    merchant { nil }
  end
end
