require 'rails_helper'

describe "Merchant Business Intelligence API" do
  it "can find x number of top ranked merchants by total revenue" do
    pam = create(:merchant)
    mallory = create(:merchant)
    archer = create(:merchant)
    ray = create(:merchant)

    lana = create(:customer)
    cyril = create(:customer)

    item_1 = create(:item, merchant: pam)
    item_2 = create(:item, merchant: pam)
    item_3 = create(:item, merchant: mallory)
    item_4 = create(:item, merchant: archer)
    item_5 = create(:item, merchant: ray)
    item_6 = create(:item, merchant: ray)

    invoice_1 = create(:invoice, merchant: pam, customer: lana)
    invoice_2 = create(:invoice, merchant: pam, customer: lana)
    invoice_3 = create(:invoice, merchant: pam, customer: lana)
    invoice_4 = create(:invoice, merchant: ray, customer: lana)
    invoice_5 = create(:invoice, merchant: mallory, customer: cyril)
    invoice_6 = create(:invoice, merchant: archer, customer: cyril)

    inv_item_1 = create(:invoice_item, item: item_1, item: item_3, invoice: invoice_1)
    inv_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2)
    inv_item_3 = create(:invoice_item, item: item_6, invoice: invoice_6)
    inv_item_4 = create(:invoice_item, item: item_1, invoice: invoice_3)
    inv_item_5 = create(:invoice_item, item: item_3, item: item_4, item: item_5, invoice: invoice_4)
    inv_item_6 = create(:invoice_item, item: item_6, invoice: invoice_5)

    trans_1 = create(:transaction, result: 0, invoice: invoice_1)
    trans_2 = create(:transaction, result: 1, invoice: invoice_2)
    trans_3 = create(:transaction, result: 1, invoice: invoice_3)
    trans_4 = create(:transaction, result: 1, invoice: invoice_4)
    trans_5 = create(:transaction, result: 1, invoice: invoice_5)
    trans_6 = create(:transaction, result: 1, invoice: invoice_6)

    get "/api/v1/merchants/most_revenue?quantity=3"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)["data"]

    expect(merchants.count).to eq(3)
    expect(merchants.first["attributes"]["id"]).to eq(pam.id)
    expect(merchants.first["attributes"]["name"]).to eq(pam.name)
  end
end
