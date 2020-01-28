class AddDefaultToTransactions < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :result, :integer, default: 0
  end
end
