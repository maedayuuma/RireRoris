class User::ItemsController < ApplicationController

  def index
    @items = Item.all.page(params[:page]).per(8)
  end

  def show
    @items = Item.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end


  private

  def item_params
    params.require(:item).permit(:image, :name, :explanation, :genre_id, :without_tax_price, :is_sale)
  end
end
