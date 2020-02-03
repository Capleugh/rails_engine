class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:shipped]

  def self.order_invoices
    order(:id)
  end
end
