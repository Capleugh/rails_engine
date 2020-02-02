class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :description, :unit_price, :merchant_id

  attribute :unit_price do |item|
    item.unit_price.to_s
  end
end
