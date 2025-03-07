# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


require_relative '../app/services/get_tickers_service'

tickers = GetTickersService.get_tickers

tickers_array = tickers["data"]


tickers_array.each do |tickers_hash|
  Stock.find_or_create_by(ticker: tickers_hash["ticker"], name: tickers_hash["security"])
end

puts "Se han guardado #{Stock.count} stocks en la base de datos."