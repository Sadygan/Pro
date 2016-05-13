class Factory < ActiveRecord::Base
	has_many :discounts
	has_many :discount_lights
	has_many :brand_models, -> { order(:brand) }, through: :products

	belongs_to :user
	
	accepts_nested_attributes_for :discount_lights, allow_destroy: true
	accepts_nested_attributes_for :discounts, allow_destroy: true
	accepts_nested_attributes_for :brand_models

	validates :brand, presence: true, uniqueness: true, length: {minimum: 2}
	validates :additional_discount, numericality: { only_integer: true }, length: {maximum: 2}

	validates :light_factor, numericality: true, length: {maximum: 6}
	validates :minimum_order, numericality: true, length: {maximum: 6}
	validates :delivery_time, numericality: { only_integer: true }, length: {maximum: 3}

	def self.options_for_select
	  order('LOWER(brand)').map { |e| [e.brand, e.id] }
	end

	discount_arr = []
	Discount.all.each { |e| discount_arr.push(e.factory_id) if e.percent != 0 }

	scope :filter_list, -> { where(id: discount_arr) }
	scope :filter_list_light, -> { where('light_factor != 0') }

	self.per_page = 1
end
