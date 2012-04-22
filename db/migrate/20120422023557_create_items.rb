class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string  :description, null: false
      t.integer :price_in_cents, default: 0, null: false
      t.string  :currency # money gem will default current to USD for us.
      t.integer :merchant_id, null: false
    end
  end

end
