class AddNumberingToGroupLine < ActiveRecord::Migration
  def change
    add_column :group_lines, :numbering, :integer
  end
end
