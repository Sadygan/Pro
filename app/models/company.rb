class Company < ActiveRecord::Base
	has_many :clients

	accepts_nested_attributes_for :clients

	validates :name, presence: true, uniqueness: true, length: {minimum: 2}
	validates :address, presence: true, length: {minimum: 2}
end
