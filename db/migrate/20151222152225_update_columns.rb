class UpdateColumns < ActiveRecord::Migration
  def up
    change_column :diesels, :received_stock, :integer, :default => 0
    change_column :diesels, :actual_stock, :integer, :default => 0
    change_column :diesels, :closing_stock, :integer, :default => 0
    change_column :diesels, :opening_meter, :integer, :default => 0
    change_column :diesels, :testing_meter, :integer, :default => 0
    change_column :diesels, :actual_sale, :integer, :default => 0
    change_column :diesels, :purchase_rate, :decimal, :default => 0
    change_column :diesels, :sale_rate, :decimal, :default => 0
  end

  def down
    change_column :diesels, :received_stock, :integer, default: nil
    change_column :diesels, :actual_stock, :integer, default: nil
    change_column :diesels, :closing_stock, :integer, default: nil
    change_column :diesels, :opening_meter, :integer, default: nil
    change_column :diesels, :testing_meter, :integer, default: nil
    change_column :diesels, :actual_sale, :integer, default: nil
    change_column :diesels, :purchase_rate, :decimal, default: nil
    change_column :diesels, :sale_rate, :decimal, default: nil
  end
end
