class Specification < ActiveRecord::Base
  belongs_to :project
  has_many :table_specifications, dependent: :destroy

  accepts_nested_attributes_for :table_specifications
  
  validates :name, presence: true

end
