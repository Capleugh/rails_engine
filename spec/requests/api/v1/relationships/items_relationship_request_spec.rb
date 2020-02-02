require 'rails_helper'

describe 'Items relationship API' do
  it 'can send a merchant associated with an item' do
    cheryl = create(:merchant)
    archer = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    create(:item, merchant: archer)

    get "/api/v1/items/#{glengoolie_blue.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant["attributes"]["id"]).to eq(cheryl.id)
    expect(merchant["attributes"]["name"]).to eq(cheryl.name)
    expect(merchant["attributes"]["name"]).to_not eq(archer.name)
  end
end
