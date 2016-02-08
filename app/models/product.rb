class Product < ActiveRecord::Base
	has_many :assets
  
  before_save :default_values

	belongs_to :factory
	belongs_to :type_furniture
	belongs_to :brand_model
	has_many :table_specifications

  validates_presence_of :factory, :factory_id
  validates_presence_of :type_furniture
  validates_presence_of :brand_model

	validates :article, presence: true
  validates :width, numericality: true, presence: true
  validates :height, numericality: true, presence: true
  validates :depth, numericality: true, presence: true
  validates :price, numericality: true, presence: true

	accepts_nested_attributes_for :assets

  attr_accessor :photo_base64, :photo_base64_form, :size_image_base64, :size_image_base64_form

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

  def first_photo id
    photo = Photo.where(product_id: id).first
  end

end
