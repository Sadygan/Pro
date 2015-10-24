class CreateFactories < ActiveRecord::Migration
  def change
    create_table :factories do |t|
      t.string :brand
      t.string :web
      t.text :autorification
      t.string :style
      t.string :line_product
      t.string :catalog
      t.integer :additional_discount
      t.string :delivery_terms # Change :delivery_term
      t.text :note

      t.float :light_factor
      t.integer :minimum_order
      t.integer :delivery_time
      t.string :group_brend

      t.references :user, index: true, foreign_key: true
      t.references :light_factory, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
