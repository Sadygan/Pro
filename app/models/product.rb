class Product < ActiveRecord::Base
	has_many :assets
  
  before_save :default_values

	belongs_to :factory
	belongs_to :type_furniture
	belongs_to :brand_model
	has_many :table_specifications

	# validates :article, uniqueness: true, presence: true
	# validates_presence_of :type_furniture, presence: true
  # validates :unit_v, numericality: true
  # validates :width, numericality: true
  # validates :height, numericality: true
  # validates :depth, numericality: true

	accepts_nested_attributes_for :assets

  def default_values
    self.price ||= 0
  end

  def shvg
  	shvg_ = 0
  	unless width.nil? || height.nil? || depth.nil?
  		shvg_ = width * height * depth
  	end
  	shvg_
  end

end
