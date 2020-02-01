class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])

    render json: MerchantSerializer.new(merchant)
  end
end

# ITEMS CONTROLLER
# merchant = Merchant.find(params[:merchant_id])
# items = merchant.items.all
# require "pry"; binding.pry
# render json: ItemSerializer.new(items)
