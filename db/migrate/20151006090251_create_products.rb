class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :article
      t.float  :price

      t.references :type_furniture, index: true, foreign_key: true
      t.references :brand_model, index: true, foreign_key: true
      
      t.string :factory_brand
      t.string :type_furniture_name
      
      t.timestamps null: false
    end
  end
end
