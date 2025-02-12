json.extract! stock, :id, :ticket, :name, :last_price, :created_at, :updated_at
json.url stock_url(stock, format: :json)
