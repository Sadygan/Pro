class AddGroupLineIdToTables < ActiveRecord::Migration
  def change
    add_reference :tables, :group_line, index: true, foreign_key: true
  end
end
