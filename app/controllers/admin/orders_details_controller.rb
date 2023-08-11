class Admin::OrdersDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_items = @order.order_items

    is_updated = true
    if @order_item.update(order_item_params)
      @order.update(status: 2) if @order_item.making_status == "manufacturing"
      @order_items.each do |order_item|
        if order_item.making_status != "finish"
          is_updated = false
        end
      end
      @order.update(status: 3) if is_updated
    end

    redirect_to admin_order_path(@order.id)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:order_id, :item_id, :quantity, :price, :making_status)
  end

end

