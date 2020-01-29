require "CSV"

namespace :import_invoice_data do
  desc "Import invoice data from csv"
  task invoices: :environment do
    Invoice.destroy_all

    file = Rails.root.join("lib", "data", "invoices.csv")
    CSV.foreach(file, headers: true) do |row|
      invoice = Invoice.create!(customer_id: row["customer_id"], merchant_id: row["merchant_id"], status: row["status"], created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
