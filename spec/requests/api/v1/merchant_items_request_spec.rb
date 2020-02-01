require 'rails_helper'

describe 'Items API' do
  it 'sends a list of merchants' do
    cheryl = create(:merchant)
    create(:item, merchant: cheryl)
    create(:item, merchant: cheryl)
    create(:item, merchant: cheryl)


    get "/api/v1/merchants/#{cheryl.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]
# require "pry"; binding.pry
    expect(items.count).to eq(3)
  end
end
