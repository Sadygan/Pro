class Product < ActiveRecord::Base
	has_many :assets
	accepts_nested_attributes_for :assets
end
