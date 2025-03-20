require 'json'
class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]

  # GET /stocks or /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1 or /stocks/1.json
  def show
  end

  def stock_data
    time_series = GetTimeSeriesService.get_time_series(@stock.ticker)
    @chart_data = time_series.map { |data| [Time.at(data["t"]).to_date, data["c"]]} if time_series

    puts "AQUI ESTAN TUS DATOS" if @chart_data.present?

    render partial: "stocks/stock_data", locals: { stock: stock, stock_price: stock_price, chart_data: chart_data }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find_by(ticker: params[:ticker])

      if @stock
        price_response = GetPriceService.get_price(@stock.ticker)
        @stock_price = price_response["p"] ? price_response["p"] : "Price not found"
      end
      unless @stock
        render file: "#{Rails.root}/public/404.html", status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:ticket, :name, :last_price)
    end
end
