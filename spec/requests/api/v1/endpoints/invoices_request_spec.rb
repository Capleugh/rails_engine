require 'rails_helper'

describe 'Invoices API' do
  it "can send one invoice" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    id = create(:invoice, customer: pam, merchant: mallory).id
    id_2 = create(:invoice, customer: lana, merchant: archer).id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["attributes"]["id"]).to eq(id)
    expect(invoice["attributes"]["id"]).to_not eq(id_2)
  end

  it "can send all invoices" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    create(:invoice, customer: pam, merchant: mallory)
    create(:invoice, customer: lana, merchant: archer)

    get "/api/v1/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]

    expect(invoices.count).to eq(2)
  end

  it "can find invoice by id" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory)
    invoice_2 = create(:invoice, customer: lana, merchant: archer)

    get "/api/v1/invoices/find?id=#{invoice_1.id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoice["attributes"]["id"]).to_not eq(invoice_2.id)
  end

  it "can find invoice by customer id" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory)
    invoice_2 = create(:invoice, customer: lana, merchant: archer)

    get "/api/v1/invoices/find?customer_id=#{pam.id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["attributes"]["customer_id"]).to eq(pam.id)
    expect(invoice["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoice["attributes"]["customer_id"]).to_not eq(lana.id)
    expect(invoice["attributes"]["id"]).to_not eq(invoice_2.id)
  end

  it "can find invoice by merchant id" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory)
    invoice_2 = create(:invoice, customer: lana, merchant: archer)

    get "/api/v1/invoices/find?merchant_id=#{mallory.id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["attributes"]["merchant_id"]).to eq(mallory.id)
    expect(invoice["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoice["attributes"]["merchant_id"]).to_not eq(archer.id)
    expect(invoice["attributes"]["id"]).to_not eq(invoice_2.id)
  end

  it "can find first invoice by status" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory, status: "shipped")
    invoice_2 = create(:invoice, customer: lana, merchant: archer, status: "shipped")

    get "/api/v1/invoices/find?status=#{invoice_1.status}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["attributes"]["status"]).to eq(invoice_1.status)
    expect(invoice["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoice["attributes"]["id"]).to_not eq(invoice_2.id)
  end

  it "can find first invoice by created at" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory, created_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")
    invoice_2 = create(:invoice, customer: lana, merchant: archer, created_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")

    get "/api/v1/invoices/find?created_at=#{invoice_1.created_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoice["attributes"]["id"]).to_not eq(invoice_2.id)
  end

  it "can find first invoice by updated at" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory, updated_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")
    invoice_2 = create(:invoice, customer: lana, merchant: archer, updated_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")

    get "/api/v1/invoices/find?updated_at=#{invoice_1.updated_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoice["attributes"]["id"]).to_not eq(invoice_2.id)
  end

  it "can find all invoices by id" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory)
    invoice_2 = create(:invoice, customer: lana, merchant: archer)

    get "/api/v1/invoices/find_all?id=#{invoice_1.id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]

    expect(invoices[0]["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoices[0]["attributes"]["id"]).to_not eq(invoice_2.id)
  end

  it "can find all invoices by customer id" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory)
    invoice_2 = create(:invoice, customer: pam, merchant: archer)
    invoice_3 = create(:invoice, customer: lana, merchant: archer)

    get "/api/v1/invoices/find_all?customer_id=#{pam.id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]

    expect(invoices[0]["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoices[1]["attributes"]["id"]).to eq(invoice_2.id)
    expect(invoices[1]["attributes"]["id"]).to_not eq(invoice_3.id)
    expect(invoices[0]["attributes"]["customer_id"]).to eq(pam.id)
    expect(invoices[1]["attributes"]["customer_id"]).to eq(pam.id)
  end

  it "can find all invoices by merchant id" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory)
    invoice_2 = create(:invoice, customer: pam, merchant: mallory)
    invoice_3 = create(:invoice, customer: lana, merchant: archer)

    get "/api/v1/invoices/find_all?merchant_id=#{mallory.id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]

    expect(invoices[0]["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoices[1]["attributes"]["id"]).to eq(invoice_2.id)
    expect(invoices[1]["attributes"]["id"]).to_not eq(invoice_3.id)
    expect(invoices[0]["attributes"]["merchant_id"]).to eq(mallory.id)
    expect(invoices[1]["attributes"]["merchant_id"]).to eq(mallory.id)
  end

  it "can find all invoices by status" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory, status: "shipped")
    invoice_2 = create(:invoice, customer: pam, merchant: mallory, status: "shipped")
    invoice_3 = create(:invoice, customer: lana, merchant: archer, status: "shipped")

    get "/api/v1/invoices/find_all?status=#{invoice_1.status}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]

    expect(invoices[0]["attributes"]["status"]).to eq(invoice_1.status)
    expect(invoices[1]["attributes"]["status"]).to eq(invoice_1.status)
    expect(invoices[2]["attributes"]["status"]).to eq(invoice_1.status)
  end

  it "can find all invoices by created at" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory, created_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")
    invoice_2 = create(:invoice, customer: lana, merchant: archer, created_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")
    invoice_3 = create(:invoice, customer: lana, merchant: archer, created_at: "Fri, 09 Feb 2020 08:32:00 UTC +00:00")

    get "/api/v1/invoices/find_all?created_at=Thu, 09 Jan 2020 08:12:00 UTC +00:00"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]
    expect(invoices[0]["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoices[1]["attributes"]["id"]).to eq(invoice_2.id)
    expect(invoices[1]["attributes"]["id"]).to_not eq(invoice_3.id)
  end

  it "can find all invoices by updated at" do
    pam = create(:customer)
    lana = create(:customer)
    mallory = create(:merchant)
    archer = create(:merchant)
    invoice_1 = create(:invoice, customer: pam, merchant: mallory, updated_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")
    invoice_2 = create(:invoice, customer: lana, merchant: archer, updated_at: "Thu, 09 Jan 2020 08:12:00 UTC +00:00")
    invoice_3 = create(:invoice, customer: lana, merchant: archer, updated_at: "Fri, 09 Feb 2020 08:32:00 UTC +00:00")

    get "/api/v1/invoices/find_all?updated_at=Thu, 09 Jan 2020 08:12:00 UTC +00:00"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]
    expect(invoices[0]["attributes"]["id"]).to eq(invoice_1.id)
    expect(invoices[1]["attributes"]["id"]).to eq(invoice_2.id)
    expect(invoices[1]["attributes"]["id"]).to_not eq(invoice_3.id)
  end
end
