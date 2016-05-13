class DiscountLights < ActiveRecord::Migration
  def change
    create_table :discount_lights do |t|
      t.integer :factor
      t.references :factory, index: true, foreign_key: true

      t.timestamps null: false
  end
end
end
