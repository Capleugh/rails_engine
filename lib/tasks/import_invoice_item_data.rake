require "CSV"

namespace :import_invoice_item_data do
  desc "Import invoice item data from csv"
  task invoice_items: :environment do
    file = Rails.root.join("lib", "data", "invoice_items.csv")
    CSV.foreach(file, headers: true) do |row|
      invoice_item = InvoiceItem.create(item_id: row["item_id"], invoice_id: row["invoice_id"], quantity: row["quantity"], unit_price: row["unit_price"], created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
