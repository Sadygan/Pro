class BrandModel < ActiveRecord::Base
	belongs_to :factory

	has_many :products
	accepts_nested_attributes_for :products, allow_destroy: true

	validates :name, presence: true
	# validates_associated :products
	def self.options_for_select
	  order('LOWER(name)').map { |e| [e.name, e.id] }
	end
end
