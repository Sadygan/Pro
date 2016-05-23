class GroupLine < ActiveRecord::Base
	belongs_to :specification
	has_many :tables
	accepts_nested_attributes_for :tables
end
