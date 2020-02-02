require 'rails_helper'

describe 'Items API' do
  it "can send one item" do
    cheryl = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    glengoolie_black = create(:item, merchant: cheryl)


    get "/api/v1/items/#{glengoolie_blue.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["attributes"]["id"]).to eq(glengoolie_blue.id)
    expect(item["attributes"]["id"]).to_not eq(glengoolie_black.id)
  end

  it "can send all items" do
    cheryl = create(:merchant)
    create(:item, merchant: cheryl)
    create(:item, merchant: cheryl)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items.count).to eq(2)
  end

  it "can find an item by id" do
    cheryl = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    glengoolie_black = create(:item, merchant: cheryl)

    get "/api/v1/items/find?id=#{glengoolie_blue.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["attributes"]["id"]).to eq(glengoolie_blue.id)
    expect(item["attributes"]["id"]).to_not eq(glengoolie_black.id)
  end

  it "can find an item by name" do
    cheryl = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    glengoolie_black = create(:item, merchant: cheryl)

    get "/api/v1/items/find?name=#{glengoolie_blue.name}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["attributes"]["name"]).to eq(glengoolie_blue.name)

    expect(item["attributes"]["name"]).to_not eq("Glengoolie Black")
  end

  it "can find an item by description" do
    cheryl = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    glengoolie_black = create(:item, merchant: cheryl)

    get "/api/v1/items/find?description=#{glengoolie_blue.description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["attributes"]["description"]).to eq(glengoolie_blue.description)

    expect(item["attributes"]["description"]).to_not eq("For the worst of times")
  end

  it "can find an item by unit price" do
    cheryl = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    glengoolie_black = create(:item, merchant: cheryl)

    get "/api/v1/items/find?unit_price=#{glengoolie_blue.unit_price}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["attributes"]["unit_price"]).to eq(glengoolie_blue.unit_price.to_s)

    expect(item["attributes"]["unit_price"]).to_not eq("For the worst of times")
  end

  it "can find an item by merchant_id" do
    cheryl = create(:merchant)
    archer = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    glengoolie_black = create(:item, merchant: archer)

    get "/api/v1/items/find?merchant_id=#{glengoolie_blue.merchant_id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["attributes"]["merchant_id"]).to eq(glengoolie_blue.merchant_id)

    expect(item["attributes"]["merchant_id"]).to_not eq(glengoolie_black.merchant_id)
  end

  it "can find an item by created_at" do
    archer = create(:merchant)
    glengoolie_blue = create(:item, created_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00", merchant: archer)
    glengoolie_black = create(:item, created_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00", merchant: archer)

    get "/api/v1/items/find?created_at=#{glengoolie_blue.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["attributes"]["id"]).to eq(glengoolie_blue.id)

    expect(item["attributes"]["id"]).to_not eq(glengoolie_black.id)
  end

  it "can find an item by updated_at" do
    archer = create(:merchant)
    glengoolie_blue = create(:item, updated_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00", merchant: archer)
    glengoolie_black = create(:item, updated_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00", merchant: archer)

    get "/api/v1/items/find?updated_at=#{glengoolie_blue.updated_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["attributes"]["id"]).to eq(glengoolie_blue.id)

    expect(item["attributes"]["id"]).to_not eq(glengoolie_black.id)
  end

  it "can find all items by id" do
    cheryl = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    glengoolie_black = create(:item, merchant: cheryl)

    get "/api/v1/items/find_all?id=#{glengoolie_blue.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item[0]["attributes"]["id"]).to eq(glengoolie_blue.id)
    expect(item[0]["attributes"]["id"]).to_not eq(glengoolie_black.id)
  end

  it "can find all items by name" do
    cheryl = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    create(:item, merchant: cheryl)

    get "/api/v1/items/find_all?name=#{glengoolie_blue.name}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item[0]["attributes"]["name"]).to eq(glengoolie_blue.name)
    expect(item[0]["attributes"]["name"]).to_not eq("Glengoolie Black")
  end

  it "can find all items by description" do
    cheryl = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    glengoolie_black = create(:item, merchant: cheryl)

    get "/api/v1/items/find_all?description=#{glengoolie_blue.description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item[0]["attributes"]["description"]).to eq(glengoolie_blue.description)
    expect(item[0]["attributes"]["description"]).to_not eq("For the worst of times")
  end

  it "can find all items by unit price" do
    cheryl = create(:merchant)
    glengoolie_blue = create(:item, unit_price: 23, merchant: cheryl)
    glengoolie_black = create(:item, unit_price: 23, merchant: cheryl)
    glengoolie_red = create(:item, unit_price: 21, merchant: cheryl)

    get "/api/v1/items/find_all?unit_price=#{glengoolie_blue.unit_price}"

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items[0]["attributes"]["unit_price"]).to eq(glengoolie_blue.unit_price.to_s)
    expect(items[1]["attributes"]["unit_price"]).to eq(glengoolie_black.unit_price.to_s)
  end

  it "can find all items by merchant id" do
    cheryl = create(:merchant)
    archer = create(:merchant)
    glengoolie_blue = create(:item, merchant: cheryl)
    glengoolie_black = create(:item, merchant: cheryl)
    glengoolie_red = create(:item, merchant: archer)

    get "/api/v1/items/find_all?merchant_id=#{glengoolie_blue.merchant_id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items[0]["attributes"]["merchant_id"]).to eq(glengoolie_blue.merchant_id)
    expect(items[1]["attributes"]["merchant_id"]).to eq(glengoolie_black.merchant_id)
  end

  it "can find all items by created at" do
    cheryl = create(:merchant)
    archer = create(:merchant)
    glengoolie_blue = create(:item, created_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00", merchant: cheryl)
    glengoolie_black = create(:item, created_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00", merchant: cheryl)
    glengoolie_red = create(:item, created_at: "Fri, 09 Jan 2020 08:12:00 UTC +00:00", merchant: archer)

    get "/api/v1/items/find_all?created_at=#{glengoolie_blue.created_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items[0]["attributes"]["id"]).to eq(glengoolie_blue.id)
    expect(items[1]["attributes"]["id"]).to eq(glengoolie_black.id)
  end

  it "can find all items by update at" do
    cheryl = create(:merchant)
    archer = create(:merchant)
    glengoolie_blue = create(:item, updated_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00", merchant: cheryl)
    glengoolie_black = create(:item, updated_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00", merchant: cheryl)
    glengoolie_red = create(:item, updated_at: "Fri, 09 Jan 2020 08:12:00 UTC +00:00", merchant: archer)

    get "/api/v1/items/find_all?updated_at=#{glengoolie_blue.updated_at}"

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items[0]["attributes"]["id"]).to eq(glengoolie_blue.id)
    expect(items[1]["attributes"]["id"]).to eq(glengoolie_black.id)
  end
end
