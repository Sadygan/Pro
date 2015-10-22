class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :article
      t.float  :price

      t.references :factory, index: true, foreign_key: true
      t.references :type_furniture, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
