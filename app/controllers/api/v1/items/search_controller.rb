class Api::V1::Items::SearchController < ApplicationController
  def show
    item = Item.find_by(request.query_parameters)

    render json: ItemSerializer.new(item)
  end

  def index
    if params[:merchant_id]
      items = Item.order_items.where(request.query_parameters)

      render json: ItemSerializer.new(items)
    elsif
      items = Item.where(request.query_parameters)

      render json: ItemSerializer.new(items)
    end
  end
end
