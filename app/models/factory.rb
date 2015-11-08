class Factory < ActiveRecord::Base
	has_many :table_specifications
	has_many :discounts
	has_many :products
	has_one  :light_factory

	belongs_to :user
	
	accepts_nested_attributes_for :table_specifications
	accepts_nested_attributes_for :products
	accepts_nested_attributes_for :discounts, allow_destroy: true

	validates :brand, presence: true, uniqueness: true, length: {minimum: 2}
	validates :additional_discount, numericality: { only_integer: true }, length: {maximum: 2}

	validates :light_factor, numericality: true, length: {maximum: 3}
	validates :minimum_order, numericality: true, length: {maximum: 5}
	validates :delivery_time, numericality: { only_integer: true }, length: {maximum: 3}
end
