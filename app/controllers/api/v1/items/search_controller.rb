class Api::V1::Items::SearchController < ApplicationController
  def show
    item = Item.find_by(items_params)

    render json: ItemSerializer.new(item)
  end

  def index
    if params[:merchant_id]
      items = Item.order_items.where(items_params)

      render json: ItemSerializer.new(items)
    elsif
      items = Item.where(items_params)

      render json: ItemSerializer.new(items)
    end
  end

  private

  def items_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
