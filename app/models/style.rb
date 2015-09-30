class Style < ActiveRecord::Base
	 has_many :projects
	 accepts_nested_attributes_for :projects
end
