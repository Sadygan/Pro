class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.integer :percent
      t.references :factory, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
