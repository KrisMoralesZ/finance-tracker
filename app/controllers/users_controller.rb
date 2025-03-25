class UsersController < ApplicationController
  def my_stocks
    @tracked_stocks = current_user.stocks

    @stock_prices ={}
    @tracked_stocks.each do |user_stock|
      price_response = GetPriceService.get_price(user_stock.ticker)
      @stock_prices[user_stock.ticker] = price_response["p"] || "N/A"
    end
  end
end
