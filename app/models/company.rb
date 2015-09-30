class Company < ActiveRecord::Base
	has_many :clients

	accepts_nested_attributes_for :clients
end
