class User::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = Address.all
  end

  def comfirm

    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @order = Order.new(order_params)
    
    if params[:order][:address_number] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name

    elsif params[:order][:address_number] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name

    elsif params[:order][:address_number] == "2"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      @cart_items = CartItem.all
      render :comfirm
    end

    @order_new = Order.new
  end

  def complete

  end

  def create
    @order = Order.new(order_params)
    @order.save

    @order = current_customer.orders.new(order_params)
    @order.save

   current_customer.cart_items.each do |cart_item|
    @order_item = OrderItem.new
    @order_item.order_id = @order.id
    @order_item.item_id = cart_item.item.id
    @order_item.price = cart_item.item.add_tax_sales_price
    @order_item.quantity = cart_item.quantity
    @order_item.save
   end
    current_customer.cart_items.destroy_all

    redirect_to orders_complete_path
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @shipping_fee = 800
  end

  private

  def order_params
    params.require(:order).permit(:total_payment, :shipping_fee, :status, :name, :address, :post_code, :payment_method)
  end
end