class MergeDateTimeFields < ActiveRecord::Migration
  def change
    change_table :diesels do |t|
      t.remove :date, :time
      t.datetime :reading_at
    end
  end
end
