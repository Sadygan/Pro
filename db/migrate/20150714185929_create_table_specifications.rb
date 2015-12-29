class CreateTableSpecifications < ActiveRecord::Migration
  def change
    create_table :table_specifications do |t|
      t.text       :finishing_for_client
      
      t.float      :unit_price_factory
      t.integer    :increment_discount
   
     
      t.integer    :percent_v
      t.text       :size
      t.integer    :number_of
      t.integer    :interest_percent
      t.integer    :arhitec_percent
      t.integer    :group
      t.float      :additional_delivery
      t.float      :additional_packaging

      t.boolean    :selected
      t.boolean    :required
      t.references :product, index: true, foreign_key: true
      t.references :specification, index: true, foreign_key: true
      t.references :discount, index: true, foreign_key: true
      t.references :delivery, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true
      t.references :size_image, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
