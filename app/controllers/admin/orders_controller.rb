class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @shipping_fee = 800
  end

  def update
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: params[:id])
    if @order.update(order_params)
     @order_items.update_all(making_status: 1) if @order.status == "confirm_payment"
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :total_payment, :shipping_fee, :status, :name, :address, :post_code, :payment_method)
  end

end
