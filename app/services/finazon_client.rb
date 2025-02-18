require 'faraday'
require 'json'
require 'dotenv/load'
class FinazonClient
  BASE_URL = 'https://api.finazon.io/latest/finazon/us_stocks_essential/tickers'
  API_KEY = ENV['FINAZON_API_KEY']
  def self.get_tickers(page_size = 1000)
    response = Faraday.get(BASE_URL) do |req|
      req.params['page_size'] = page_size
      req.params['apikey'] = API_KEY
    end

    if response.success?
      json = JSON.parse(response.body)
      json['data'].map { |stock| OpenStruct.new(stock) }
    else
      file_path = Rails.root.join("db", "mock_data.json")
      file = File.read(file_path)
      json = JSON.parse(file)
      json['data'].map { |stock| OpenStruct.new(stock) }
    end
  rescue Faraday::Error => e
    { error: e.message }
  end
end