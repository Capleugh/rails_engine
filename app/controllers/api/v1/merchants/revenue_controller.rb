class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    merchants = Merchant.limit(request.query_parameters)

    render json: MerchantSerializer.new(merchants)
  end
end
