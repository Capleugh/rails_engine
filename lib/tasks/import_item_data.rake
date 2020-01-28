require "CSV"

namespace :import_item_data do
  desc "Import item data from csv"
  task items: :environment do
    file = Rails.root.join("lib", "data", "items.csv")
    CSV.foreach(file, headers: true) do |row|
      item = Item.create(name: row["name"], description: row["description"], unit_price: row["unit_price"], merchant_id: row["merchant_id"], created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
