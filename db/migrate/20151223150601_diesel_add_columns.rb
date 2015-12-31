class DieselAddColumns < ActiveRecord::Migration
  def change
    add_column :diesels, :closing_meter, :integer, null: false, :default=>0
    add_column :diesels, :opening_stock, :integer, null: false, :default=>0
  end
end
