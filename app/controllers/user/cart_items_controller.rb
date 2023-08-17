class User::CartItemsController < ApplicationController

  before_action :login_check, only: [:create]

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_items = current_customer.cart_items.all
    if @cart_items.find_by(item_id: @cart_item.item_id)
      cart_item = @cart_items.find_by(item_id: @cart_item.item_id)
      new_quantity = cart_item.quantity + @cart_item.quantity
      cart_item.update_attribute(:quantity, new_quantity)
    else
      @cart_item.save
    end
    redirect_to cart_items_path
  end

  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    cart_items = CartItem.all
    cart_items.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :quantity)
  end

  private

  def login_check
   unless customer_signed_in?
    flash[:alert] = "ログインしてください"
    redirect_to items_path
   end
  end

end