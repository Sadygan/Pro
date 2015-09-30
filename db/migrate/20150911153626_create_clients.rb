class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :status_position
      t.string :telephone
      t.string :email

      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
