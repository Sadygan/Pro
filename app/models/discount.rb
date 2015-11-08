class Discount < ActiveRecord::Base
  has_many :table_specifications
  belongs_to :factory

  accepts_nested_attributes_for :table_specifications

  validates :percent, numericality: { only_integer: true }
end
