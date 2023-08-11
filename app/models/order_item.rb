class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def total_price
		item.add_tax_sales_price * quantity
  end

  def subtotal
    item.without_tax_price* quantity
  end

  enum making_status: {impossible_manufacture:0,waiting_manufacture:1,manufacturing:2,finish:3}
end
