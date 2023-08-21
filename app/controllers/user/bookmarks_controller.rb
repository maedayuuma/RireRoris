class User::BookmarksController < ApplicationController
  before_action :authenticate_customer!

  def index
     @items = Item.all
     @bookmarks = Bookmark.where(item_id: @items, customer_id: current_customer.id)
  end

  def create
      @item = Item.find(params[:item_id])
      @bookmark = @item.bookmarks.new
      @bookmark.customer = current_customer
    if @bookmark.save
      redirect_to item_path(@item)
    else
      @cart_item = CartItem.new
      @reviews = Review.all
      @review = Review.new
      @all_rating = '総合評価'
      render "user/items/show"
    end
  end

  def destroy
      @item = Item.find(params[:item_id])
      @bookmark = Bookmark.find_by(item_id: @item, customer_id: current_customer.id)
    if @bookmark.present?
       @bookmark.destroy
       redirect_to item_path(@item)
    else
      @cart_item = CartItem.new
      @reviews = Review.all
      @review = Review.new
      @all_rating = '総合評価'
      render "user/items/show"
    end
  end
end
