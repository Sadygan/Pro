class ChangeGroupLine < ActiveRecord::Migration
  def change
    rename_column :group_lines, :table_id, :specification_id
  end
end
