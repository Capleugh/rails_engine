class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: [:fail, :success]
end
