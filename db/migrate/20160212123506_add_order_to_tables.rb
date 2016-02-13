class AddOrderToTables < ActiveRecord::Migration
  def change
    add_column :tables, :order, :integer
  end
end
