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
end
