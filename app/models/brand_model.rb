class BrandModel < ActiveRecord::Base
	belongs_to :factory

	has_many :products
	accepts_nested_attributes_for :products, allow_destroy: true

	# validates :name, presence: true, uniqueness: true
	# validates_associated :products
end
