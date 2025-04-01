class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def my_stocks
    @tracked_stocks = current_user.stocks

    @stock_prices ={}
    @tracked_stocks.each do |user_stock|
      price_response = GetPriceService.get_price(user_stock.ticker)
      @stock_prices[user_stock.ticker] = price_response["p"] || "N/A"
    end
  end

  def my_friends
    @friends = current_user.friends
  end
end
