class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.merchants_ranked_by_revenue(limit)
    joins(invoices: [:invoice_items, :transactions])
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group(:id)
    .merge(Transaction.successful)
    .order('revenue desc')
    .limit(limit)
  end
end
