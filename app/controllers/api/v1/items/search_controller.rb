class Api::V1::Items::SearchController < ApplicationController
  def show
    item = Item.find_by(request.query_parameters)

    render json: ItemSerializer.new(item)
  end
end
