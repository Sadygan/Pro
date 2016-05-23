class CreateGroupLines < ActiveRecord::Migration
  def change
    create_table :group_lines do |t|
      t.string :name
      t.string :note

      t.references :table, index: true, foreign_key: true

      t.timestamps null: false
	  end
	end
end
