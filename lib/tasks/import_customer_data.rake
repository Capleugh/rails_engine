require "CSV"

namespace :import_customer_data do
  desc "Import customer data from csv"
  task customers: :environment do
    file = Rails.root.join("lib", "data", "customers.csv")
    CSV.foreach(file, headers: true) do |row|
      customer = Customer.create(first_name: row["first_name"], last_name: row["last_name"], created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
