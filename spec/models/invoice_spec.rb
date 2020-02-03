require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should belong_to :merchant }

    it { should have_many :transactions}
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items)}
  end

  describe 'class methods' do
    it "self.order_invoices can order invoices by invoice id" do
      pam = create(:customer)
      lana = create(:customer)
      mallory = create(:merchant)
      archer = create(:merchant)
      invoice_1 = create(:invoice, customer: lana, merchant: mallory)
      invoice_2 = create(:invoice, customer: lana, merchant: archer)
      invoice_3 = create(:invoice, customer: lana, merchant: archer)

      expect(Invoice.order_invoices).to eq([invoice_1, invoice_2, invoice_3])
    end
  end
end
