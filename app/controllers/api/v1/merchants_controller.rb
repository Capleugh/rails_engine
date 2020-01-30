class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: MerchantSerializer.new(merchants)
  end

  def show
    if params[:filter] == "find"
      merchant = Merchant.find_by(request.query_parameters)
      render json: MerchantSerializer.new(merchant)
    elsif merchant = Merchant.find(params[:filter])
      render json: MerchantSerializer.new(merchant)
    end
  end
end
