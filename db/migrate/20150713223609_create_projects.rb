class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :object_name
      t.string :type_furniture
      # t.date :date_request
      t.date :deadline
      t.float :planned_budget
      t.date :date_delivery_client
      t.float :amount_contract
      t.float :client_prepayment
      t.float :client_surcharge
      t.text :status_transaction
      t.text :delivery_status
      t.boolean :print_sum

      t.references :user, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true
      t.references :style, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
