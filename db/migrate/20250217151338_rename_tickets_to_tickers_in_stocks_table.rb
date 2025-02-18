class RenameTicketsToTickersInStocksTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :stocks, :ticket, :ticker
  end
end
