class TypeFurniture < ActiveRecord::Base
	has_one	 :product
	scope :name_like, -> (name) { where("name ilike ?", name)}

    validates :name, presence: true, uniqueness: true, length: {minimum: 2}

	def self.options_for_select
	  order('LOWER(name)').map { |e| [e.name, e.id] }
	end

end
