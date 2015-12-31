class AddTotalStockColumn < ActiveRecord::Migration
  def change
    add_column :diesels, :total_stock, :integer, null: false, :default=>0
  end
end
