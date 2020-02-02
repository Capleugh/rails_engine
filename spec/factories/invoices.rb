FactoryBot.define do
  factory :invoice do
    customer { nil }
    merchant { nil }
    status { 0 }
  end
end
