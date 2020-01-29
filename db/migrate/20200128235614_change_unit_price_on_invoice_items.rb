class ChangeUnitPriceOnInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    change_column :invoice_items, :unit_price, :decimal
  end
end
