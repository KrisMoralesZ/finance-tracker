require 'faraday'
require 'json'
require 'dotenv/load'
  class GetTickersService
  BASE_URL = 'https://api.finazon.io/latest/finazon/us_stocks_essential/tickers'
  API_KEY = ENV['FINAZON_API_KEY']
  def self.get_tickers(page_size = 1000)
    response = Faraday.get(BASE_URL) do |req|
      req.params['page_size'] = page_size
      req.params['apikey'] = API_KEY
    end

    if response.success?
      JSON.parse(response.body)
    else
      { error: "#{response.status}" }
    end
  rescue Faraday::Error => e
    { error: e.message }
  end
end