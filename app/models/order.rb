class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  def total_price
    order_items.to_a.sum {|item| item.total_price}
  end

  enum status: {wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4}
  enum payment_method: { credit_card: 0, transfer: 1 }
end
