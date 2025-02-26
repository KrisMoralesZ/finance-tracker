require 'faraday'
require 'json'
require 'dotenv/load'

class GetTimeSeriesService
  BASE_URL = 'https://api.finazon.io/latest/finazon/us_stocks_essential/time_series'
  API_KEY = ENV['FINAZON_API_KEY']

  def self.get_time_series(ticker)
    response = Faraday.get(BASE_URL) do |req|
      req.params['ticker'] = ticker
      req.params['interval'] = '1d'
      req.params['page'] = 0
      req.params['page_size'] = 30
      req.params['adjust'] = 'all'
      req.params['apikey'] = API_KEY
    end

    if response.success?
      JSON.parse(response.body)["data"]
    else
      { error: response.body }
    end
  rescue Faraday::Error => e
    { error: e.message }
  end
end
