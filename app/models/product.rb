class Product < ActiveRecord::Base
	has_many :assets
	has_one :table_specification
	belongs_to :factory
	belongs_to :type_furniture

	# validates_presence_of :type_furniture_id, message: "^We need to know who is filling in this form (your name)"
	validates_presence_of :type_furniture

	accepts_nested_attributes_for :assets
end
