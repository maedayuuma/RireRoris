class Address < ApplicationRecord
  belongs_to :customer
  validates :post_code, :address, :name, presence: true
  def address_display
  '〒' + post_code + ' ' + address + ' ' + name
  end
end
