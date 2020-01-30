require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)["data"]

    expect(merchants.count).to eq(3)
  end

  it 'can send a single merchant' do
    id = create(:merchant).id
    pam = create(:merchant)


    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end






########## come back and test first and last
  it 'can find a single merchant by its id' do
    cheryl = create(:merchant)
    pam = create(:merchant)

    id = cheryl.id

    #get "/api/v1/merchants/find?id=254", params: { id: id }
    get "/api/v1/merchants/find?id=#{id}"
    merchant = JSON.parse(response.body)["data"]
    #require "pry"; binding.pry
    expect(response).to be_successful
    expect(merchant["attributes"]["id"]).to eq(cheryl.id)
  end

  it 'can find a single merchant by its name' do
    cheryl = create(:merchant)
    pam = create(:merchant)

    get "/api/v1/merchants/find?name=#{cheryl.name}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["name"]).to eq(cheryl.name)
  end

  it 'can find a single merchant by created at' do
    cheryl = create(:merchant)
    pam = create(:merchant)


    get "/api/v1/merchants/find?created_at=#{cheryl.created_at}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["id"]).to eq(cheryl.id)
  end

  it 'can find a single merchant by updated at' do
    cheryl = create(:merchant)
    pam = create(:merchant)


    get "/api/v1/merchants/find?updated_at=#{cheryl.updated_at}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["id"]).to eq(cheryl.id)
  end

  it 'it can find all merchant by id' do
    
  end
end
