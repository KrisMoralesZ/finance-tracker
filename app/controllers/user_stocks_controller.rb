class UserStocksController < ApplicationController

  def create
    stock = Stock.find(params[:stock_id])
    current_user.user_stocks.find_or_create_by(stock: stock)

    redirect_to my_stocks_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = current_user.user_stocks.find_by(stock: stock)

    if user_stock
      user_stock.destroy
      redirect_to my_stocks_path, notice: "Stock Deleted"
    else
      redirect_to my_stocks_path, notice: "Stock not found"
    end
  end
end
