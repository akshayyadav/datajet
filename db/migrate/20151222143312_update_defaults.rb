class UpdateDefaults < ActiveRecord::Migration
  def change
    change_column_default :diesels, :received_stock, from: nil, to: 000
    change_column_default :diesels, :actual_stock, from: nil, to: 000
    change_column_default :diesels, :closing_stock, from: nil, to: 000
    change_column_default :diesels, :opening_meter, from: nil, to: 000
    change_column_default :diesels, :testing_meter, from: nil, to: 000
    change_column_default :diesels, :actual_sale, from: nil, to: 000
    change_column_default :diesels, :purchase_rate, from: nil, to: 000
    change_column_default :diesels, :sale_rate, from: nil, to: 000
  end
end
