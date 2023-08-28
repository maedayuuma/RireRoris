class Admin::ItemsController < ApplicationController

 def index
  @items = Item.all
 end

 def new
   @item = Item.new
   @genres = Genre.all
 end

 def create
   @item = Item.new(item_params)
  if @item.save
   redirect_to admin_item_path(@item)
  else
   @item = Item.new
   @genres = Genre.all
   render :new
  end
 end

 def show
  @item = Item.find(params[:id])
  @genres = Genre.all
  @reviews = @item.reviews
  @all_rating = '総合評価'
 end

 def edit
  @item = Item.find(params[:id])
  @genres = Genre.all
 end

 def update
  @item = Item.find(params[:id])
  @item.update(item_params)
  redirect_to admin_item_path(@item)
 end

  private

  def item_params
    params.require(:item).permit(:image, :name, :explanation, :genre_id, :without_tax_price, :is_sale)
  end
end