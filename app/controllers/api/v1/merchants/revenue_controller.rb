class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    limit_merchants = request.query_parameters["quantity"].to_i
    merchants = Merchant.merchants_ranked_by_revenue(limit_merchants)

    render json: MerchantSerializer.new(merchants)
  end
end
