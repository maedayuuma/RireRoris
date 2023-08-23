class User::ItemsController < ApplicationController

  def index
    #@item = Item.all.page(params[:page]).per(10)
    @genres = Genre.all
    @item = @q.result(distinct: true).page(params[:page]).order("created_at desc")

  end

  def genre_search
    @genre = Genre.find(params[:id])
    @items = @genre.items.order(created_at: :DESC)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @reviews = @item.reviews
    @review = Review.new
    @all_rating = '総合評価'
    @bookmark = Bookmark.new
    @genres = Genre.all
  end


  private

  def items_params
    params.require(:item).permit(:image, :name, :explanation, :genre_id, :without_tax_price, :is_sale)
  end
end
