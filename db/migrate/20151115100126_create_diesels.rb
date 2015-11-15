class CreateDiesels < ActiveRecord::Migration
  def change
    create_table :diesels do |t|
      t.date :date
      t.time :time
      t.integer :current_stock

      t.timestamps null: false
    end
  end
end
