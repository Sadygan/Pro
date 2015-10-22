class Factory < ActiveRecord::Base
	has_many :table_specifications
	has_many :discounts
	has_many :products

	belongs_to :user
	
	accepts_nested_attributes_for :table_specifications
	accepts_nested_attributes_for :products
	accepts_nested_attributes_for :discounts, allow_destroy: true

end
