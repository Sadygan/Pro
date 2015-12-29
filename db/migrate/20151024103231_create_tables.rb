class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string     :finishing
      t.text       :finishing_for_client
      
      t.float      :unit_price_factory
      t.integer    :increment_discount
      
      # V & weight
      t.text       :size

      t.integer    :percent_v
      t.integer    :number_of
      t.integer    :interest_percent
      t.integer    :arhitec_percent
      t.integer    :group
      t.float      :additional_delivery
      t.float      :additional_packaging

      t.string     :type

      t.boolean    :required
      t.references :product, index: true, foreign_key: true
      t.references :specification, index: true, foreign_key: true
      t.references :discount, index: true, foreign_key: true
      t.references :delivery, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true
      t.references :size_image, index: true, foreign_key: true
      t.timestamps null: false

      t.timestamps null: false
    end
  end
end
