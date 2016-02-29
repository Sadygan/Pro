class Factory < ActiveRecord::Base
	has_many :discounts
	has_many :brand_models, -> { order(:brand) }, through: :products
	has_one  :light_factory

	belongs_to :user
	
	accepts_nested_attributes_for :discounts, allow_destroy: true
	accepts_nested_attributes_for :brand_models

	validates :brand, presence: true, uniqueness: true, length: {minimum: 2}
	validates :additional_discount, numericality: { only_integer: true }, length: {maximum: 2}

	validates :light_factor, numericality: true, length: {maximum: 5}
	validates :minimum_order, numericality: true, length: {maximum: 5}
	validates :delivery_time, numericality: { only_integer: true }, length: {maximum: 3}

	def self.options_for_select
	  order('LOWER(brand)').map { |e| [e.brand, e.id] }
	end
end
