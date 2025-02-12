class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :ticket
      t.string :name
      t.decimal :last_price

      t.timestamps
    end
  end
end
