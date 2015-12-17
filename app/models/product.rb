class Product < ActiveRecord::Base
	has_many :assets

	belongs_to :factory
	belongs_to :type_furniture
	belongs_to :brand_model
	
	validates :article, uniqueness: true, presence: true
	validates_presence_of :type_furniture

	accepts_nested_attributes_for :assets

  before_save :default_values
  def default_values
    self.price ||= 0
  end

end
