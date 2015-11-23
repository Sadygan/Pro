class AddModelToProduct < ActiveRecord::Migration
  def change
    add_column :products, :model, :string
  end
end
