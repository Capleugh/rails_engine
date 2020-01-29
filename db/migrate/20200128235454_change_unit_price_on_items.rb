class ChangeUnitPriceOnItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :unit_price, :decimal
  end
end
