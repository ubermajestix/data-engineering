class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :purchaser_id, null: false
      t.integer :item_id, null: false
      t.timestamps
    end
  end
end
