class City < ActiveRecord::Base
	 has_many :projects
	 accepts_nested_attributes_for :projects

	 validates :name, presence: true, uniqueness: true, length: {minimum: 2}
end
