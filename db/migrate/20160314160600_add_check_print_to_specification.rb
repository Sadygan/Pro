class AddCheckPrintToSpecification < ActiveRecord::Migration
  def change
  	add_column :specifications, :photo, 		:boolean
  	add_column :specifications, :factory, 		:boolean
  	add_column :specifications, :brand_model, 	:boolean
  	add_column :specifications, :article, 		:boolean
  	add_column :specifications, :finishing, 	:boolean
  	add_column :specifications, :description, 	:boolean
  	add_column :specifications, :size, 			:boolean
  	add_column :specifications, :upf, 			:boolean
  	add_column :specifications, :sum_factory, 	:boolean
  	add_column :specifications, :number_of, 	:boolean
  	add_column :specifications, :interest, 		:boolean
  	add_column :specifications, :full_price, 	:boolean
  	add_column :specifications, :full_sum, 		:boolean
  	add_column :specifications, :v, 			:boolean
  	add_column :specifications, :architector, 	:boolean
  end
end
