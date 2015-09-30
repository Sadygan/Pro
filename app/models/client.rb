class Client < ActiveRecord::Base
	has_many :projects
	belongs_to :company

	accepts_nested_attributes_for :projects
end
