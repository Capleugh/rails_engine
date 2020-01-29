require "CSV"

namespace :import_merchant_data do
  desc "Import merchant data from csv"
  task merchants: :environment do
    Merchant.destroy_all
    file = Rails.root.join("lib", "data", "merchants.csv")
    CSV.foreach(file, headers: true) do |row|
      merchant = Merchant.create(name: row["name"], created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
