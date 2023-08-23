class User::GenresController < ApplicationController

  def index
    @item = Item.all.page(params[:page]).per(10)
    @genres = Genre.all
  end

  def genre_search
    @genre = Genre.find(params[:id])
    @items = @genre.items.order(created_at: :DESC)
  end

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end
end