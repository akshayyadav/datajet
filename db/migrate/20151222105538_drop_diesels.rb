class DropDiesels < ActiveRecord::Migration
  def change
    drop_table :diesels do |t|
      t.datetime :reading_at
      t.integer :current_stock

      t.timestamps null: false
    end

    create_table :diesels do |t|
      t.date :reading_at

      #t.integer :opening_stock                  # Previous day closing stock reading
      t.integer :received_stock, null: false    # Stock bought
      t.integer :actual_stock, null: false      # Actual dip reading
      t.integer :closing_stock                  # Closing stock = total_stock - actual_sale

      t.integer :opening_meter, null: false
      #t.integer :closing_meter, null: false    # Next day opening meter
      t.integer :testing_meter, null: false

      t.integer :actual_sale                    # closing_meter - opening_meter - pump_testing

      t.decimal :purchase_rate, precision: 6, scale: 3, null: false
      t.decimal :sale_rate, precision: 6, scale: 3, null: false
    end
  end
end
