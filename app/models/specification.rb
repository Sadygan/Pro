class Specification < ActiveRecord::Base
  belongs_to :project
  has_many :table_specifications, dependent: :destroy
  has_many :table_specification_lights, dependent: :destroy
  has_many :tables, dependent: :destroy

  accepts_nested_attributes_for :table_specifications
  accepts_nested_attributes_for :table_specification_lights
  accepts_nested_attributes_for :tables
  
  validates :name, presence: true, length: {minimum: 2}

end
