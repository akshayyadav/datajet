class AddRecordChangeTracking < ActiveRecord::Migration
  def change
    change_table :diesels do |t|
      t.timestamps
    end
  end

end
