class CreateTypeFurnitures < ActiveRecord::Migration
  def change
    create_table :type_furnitures do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
