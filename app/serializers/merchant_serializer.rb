class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  has_many :items

  attributes :id, :name
end
