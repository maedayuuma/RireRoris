class User::ReviewsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.new(review_params)
    @review.customer = current_customer
    if @review.save
      redirect_to item_path(@item)
    else
      @cart_item = CartItem.new
      @reviews = Review.all
      @all_rating = '総合評価'
      @bookmark = Bookmark.new
      render "user/items/show"
    end
  end

  def review_params
    params.require(:review).permit(:comment, :all_rating)
  end
end