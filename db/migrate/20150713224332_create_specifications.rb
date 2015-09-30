class CreateSpecifications < ActiveRecord::Migration
  def change
    create_table :specifications do |t|
      t.string :name
      t.boolean :light
      t.boolean :print_sum
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
