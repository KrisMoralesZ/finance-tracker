class UserStocksController < ApplicationController

  def create
    stock = Stock.find(params[:stock_id])
    current_user.user_stocks.find_or_create_by(stock: stock)

    redirect_to my_stocks_path
  end
end
