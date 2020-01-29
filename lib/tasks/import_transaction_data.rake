require "CSV"

namespace :import_transaction_data do
  desc "Import transaction data from csv"
  task transactions: :environment do
    Transaction.destroy_all
    
    file = Rails.root.join("lib", "data", "transactions.csv")
    CSV.foreach(file, headers: true) do |row|
      transaction = Transaction.create(invoice_id: row["invoice_id"], credit_card_number: row["credit_card_number"], credit_card_expiration_date: row["credit_card_expiration_date"], result: row["result"], created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
