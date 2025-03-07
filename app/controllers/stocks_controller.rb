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

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to stocks_path, status: :see_other, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
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
