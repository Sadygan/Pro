class AddNoteToSpecification < ActiveRecord::Migration
  def change
    add_column :specifications, :note, :boolean
  end
end
