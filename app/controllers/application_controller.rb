class ApplicationController < ActionController::Base

  before_action :set_q
  def set_q
    @q = Item.ransack(params[:q])
  end


 def search
    @item = Item.find(params[:item_id])
    @q = Item.ransack(params[:q])
    @searchs = @q.result(distinct: true).includes(:@q).page(params[:page]).order("created_at desc")
 end
end
