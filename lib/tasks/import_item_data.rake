require "CSV"

def dollar_conversion(price_in_cents)
  price_in_cents.to_f / 100
end

namespace :import_item_data do
  desc "Import item data from csv"
  task items: :environment do
    Item.destroy_all

    file = Rails.root.join("lib", "data", "items.csv")
    CSV.foreach(file, headers: true) do |row|
      item = Item.create(name: row["name"], description: row["description"], unit_price: dollar_conversion(row["unit_price"]), merchant_id: row["merchant_id"], created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
