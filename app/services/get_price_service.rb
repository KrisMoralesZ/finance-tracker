require 'faraday'
require 'json'
require 'dotenv/load'
class GetPriceService
  BASE_URL = 'https://api.finazon.io/latest/finazon/us_stocks_essential/price?ticker='
  API_KEY = ENV['FINAZON_API_KEY']

  def self.get_price(ticker_name)
    response = Faraday.get(BASE_URL) do |req|
      req.params['ticker'] = ticker_name
      req.params['apikey'] = API_KEY
    end

    if response.success?
      JSON.parse(response.body)

    else
      { error: response.body }
    end
  rescue Faraday::Error => e
    { error: e.message }
  end
end