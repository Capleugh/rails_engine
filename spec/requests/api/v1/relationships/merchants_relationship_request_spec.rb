require 'rails_helper'

describe 'Merchants relationship API' do
  it 'can send a list of items associated with a merchant' do
    cheryl = create(:merchant)
    create(:item, merchant: cheryl)
    create(:item, merchant: cheryl)
    create(:item, merchant: cheryl)

    get "/api/v1/merchants/#{cheryl.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items.count).to eq(3)
  end

  it 'can send a list of invoices associated with a merchant' do

    pam = create(:customer)
    lana = create(:customer)
    archer = create(:merchant)
    mallory = create(:merchant)
    create(:invoice, customer: pam, merchant: mallory)
    create(:invoice, customer: pam, merchant: archer)
    create(:invoice, customer: lana, merchant: archer)

    get "/api/v1/merchants/#{archer.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]

    expect(invoices.count).to eq(2)
  end
end
