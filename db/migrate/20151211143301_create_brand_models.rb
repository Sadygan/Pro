class CreateBrandModels < ActiveRecord::Migration
  def change
    create_table :brand_models do |t|
      t.string :name

      t.references :factory, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
