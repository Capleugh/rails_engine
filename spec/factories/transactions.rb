FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "123456789101" }
    credit_card_expiration_date { "0925" }
    result { 1 }
  end
end
