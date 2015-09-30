class CreateTableSpecifications < ActiveRecord::Migration
  def change
    create_table :table_specifications do |t|
      t.attachment :image
      t.string     :article
      t.text       :type_fyrniture
      t.string     :finishing
      t.text       :finishing_for_client
      
      t.float      :unit_price_factory
      t.integer    :increment_discount
      
      # V & weight
      t.text       :size
      t.attachment :size_image 
      t.float      :weight
      t.float      :width
      t.float      :height
      t.float      :depth
      t.integer    :percent_v
      t.float      :unit_v
      
      t.float      :factor
      t.integer    :number_of
      t.integer    :interest_percent
      t.integer    :arhitec_percent
      t.integer    :group
      t.float      :additional_delivery

      t.boolean    :required
      t.references :specification, index: true, foreign_key: true
      t.string     :factory_brand, index: true, foreign_key: true
      t.references :factory, index: true, foreign_key: true
      t.references :discount, index: true, foreign_key: true
      t.references :delivery, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
