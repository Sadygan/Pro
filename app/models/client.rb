class Client < ActiveRecord::Base
	has_many :projects
	belongs_to :company

	accepts_nested_attributes_for :projects

	validates :name, presence: true, uniqueness: true
	validates :status_position, presence: true
	validates :telephone, presence: true, numericality: { only_integer: true }
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
