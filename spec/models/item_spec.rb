require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }

    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'class methods' do
    it "self.order_items can order items by item id" do
      archer = create(:merchant)
      item_1 = create(:item, merchant: archer)
      item_2 = create(:item, merchant: archer)
      item_3 = create(:item, merchant: archer)

      expect(Item.order_items).to eq([item_1, item_2, item_3])
    end
  end
end
