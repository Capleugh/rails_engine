class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: [:fail, :success]

  scope :successful, -> {where(result: 'success')}

  def self.successful
    where(result: 'success')
  end
end
