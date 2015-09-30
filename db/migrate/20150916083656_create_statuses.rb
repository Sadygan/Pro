class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.string :description

      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
