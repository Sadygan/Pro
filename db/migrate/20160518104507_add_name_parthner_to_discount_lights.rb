class AddNameParthnerToDiscountLights < ActiveRecord::Migration
  def change
    add_column :discount_lights, :name_parthner, :string
  end
end
