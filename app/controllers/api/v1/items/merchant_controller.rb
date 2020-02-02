class Api::V1::Items::MerchantController < ApplicationController
  def index
    # index because you aren't grabbing something by a merchant's id. Just by an item's id
    item = Item.find(params[:item_id])
    merchant = item.merchant

    render json: MerchantSerializer.new(merchant)
  end
end
