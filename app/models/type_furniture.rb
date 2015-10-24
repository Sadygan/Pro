class TypeFurniture < ActiveRecord::Base
	has_one	 :product
	scope :name_like, -> (name) { where("name ilike ?", name)}

end

# create_table :type_furniture do |t|
#   t.column :name, :string
# end