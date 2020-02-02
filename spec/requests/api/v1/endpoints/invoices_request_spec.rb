require 'rails_helper'

describe 'Invoices API' do
  it "can send one item" do
    customer = create(:customer)
    customer_2 = create(:customer)
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    id = create(:invoice, customer: customer, merchant: merchant).id
    id_2 = create(:invoice, customer: customer_2, merchant: merchant_2).id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["attributes"]["id"]).to eq(id)
    expect(invoice["attributes"]["id"]).to_not eq(id_2)
  end

  it "can send all invoices" do
    customer = create(:customer)
    customer_2 = create(:customer)
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer_2, merchant: merchant_2)

    get "/api/v1/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]

    expect(invoices.count).to eq(2)
  end
end
