class Delivery < ActiveRecord::Base
	has_many :table_specifications

	accepts_nested_attributes_for :table_specifications

	validates :direction, presence: true, uniqueness: true

  validates :cost, numericality: { only_integer: false }
end
