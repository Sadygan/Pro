class BrandModel < ActiveRecord::Base
	belongs_to :factory
	has_many :products, :dependent => :nullify
	accepts_nested_attributes_for :products, allow_destroy: true
	validates :name, presence: true
	validates :factory_id, presence: true

	def self.options_for_select
	  order('LOWER(name)').map { |e| [e.name, e.id] }
	end

	scope :filter_list, -> { where(factory: Factory.filter_list) }
	scope :filter_list_light, -> { where(factory: Factory.filter_list_light) }

end
