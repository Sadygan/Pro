class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :direction
      t.integer :cost
      t.integer :execution_document
      t.integer :check_factory
      t.integer :bank_service
      t.float :bank_percent

      t.timestamps null: false
    end
  end
end
