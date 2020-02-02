class Api::V1::ItemsController < ApplicationController
  def show
    item = Item.find(params[:id])

    render json: ItemSerializer.new(item)
  end

  def index
    items = Item.all

    render json: ItemSerializer.new(items)
  end
end
