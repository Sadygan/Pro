class AddNoteToTable < ActiveRecord::Migration
  def change
    add_column :tables, :note, :string
  end
end
