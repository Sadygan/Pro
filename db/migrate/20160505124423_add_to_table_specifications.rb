class AddToTableSpecifications < ActiveRecord::Migration
  def change
    add_column :tables, :type_of_size_id, :integer
  end
end
