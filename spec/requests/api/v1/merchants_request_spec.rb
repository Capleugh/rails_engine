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
    id_1 = create(:merchant).id
    id_2 = create(:merchant).id


    get "/api/v1/merchants/#{id_1}"

    merchant = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id_1)
    expect(merchant["id"]).to_not eq(id_2)
  end


########## come back and test first and last
  it 'can find a single merchant by its id' do
    id_1 = create(:merchant).id
    id_2 = create(:merchant).id

    get "/api/v1/merchants/find?id=#{id_1}"
    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["id"]).to eq(id_1)
    expect(merchant["attributes"]["id"]).to_not eq(id_2)
  end

  it 'can find a single merchant by its name' do
    cheryl = create(:merchant).name
    pam = create(:merchant).name

    get "/api/v1/merchants/find?name=#{cheryl}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant["attributes"]["name"]).to eq(cheryl)
    expect(merchant["attributes"]["name"]).to_not eq(pam)
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

  it 'it can find all merchants id' do
    id_1 = create(:merchant).id
    id_2 = create(:merchant).id
    create(:merchant)

    get "/api/v1/merchants/find_all?id=#{id_1}"

    merchant = JSON.parse(response.body)["data"]
    expect(response).to be_successful

    expect(merchant[0]["attributes"]["id"]).to eq(id_1)
    expect(merchant[0]["attributes"]["id"]).to_not eq(id_2)
    expect(merchant.count).to eq(1)
  end

  it 'can find all merchants by name' do
    cheryl = create(:merchant, name: "Cheryl")
    create(:merchant, name: "Cheryl")
    create(:merchant)

    get "/api/v1/merchants/find_all?name=Cheryl"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(merchant[0]["attributes"]["name"]).to eq("Cheryl")
    expect(merchant.count).to eq(2)
  end

  it 'can find all merchants by created_at' do
    cheryl = create(:merchant, created_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")
    pam = create(:merchant, created_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")
    create(:merchant)

    get "/api/v1/merchants/find_all?created_at=Thu, 09 Jan 2020 08:12:00 UTC +00:00"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(merchant[0]["attributes"]["name"]).to eq(cheryl.name)
    expect(merchant[1]["attributes"]["name"]).to eq(pam.name)
    expect(merchant.count).to eq(2)
  end

  it 'can find all merchants by updated_at' do
    cheryl = create(:merchant, updated_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")
    pam = create(:merchant, updated_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")
    create(:merchant)

    get "/api/v1/merchants/find_all?updated_at=Thu, 09 Jan 2020 08:12:00 UTC +00:00"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(merchant[0]["attributes"]["name"]).to eq(cheryl.name)
    expect(merchant[1]["attributes"]["name"]).to eq(pam.name)
    expect(merchant.count).to eq(2)
  end
end
