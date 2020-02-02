require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items associated with a merchant' do
    cheryl = create(:merchant)
    create(:item, merchant: cheryl)
    create(:item, merchant: cheryl)
    create(:item, merchant: cheryl)

    get "/api/v1/merchants/#{cheryl.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items.count).to eq(3)
  end

  it 'test an item can find an associated merchant' do
    cheryl = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    glengoolie_black = create(:item, merchant: cheryl)

    get "/api/v1/items/#{glengoolie_blue.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant["attributes"]["id"]).to eq(cheryl.id)
    expect(merchant["attributes"]["name"]).to eq(cheryl.name)
  end
end
