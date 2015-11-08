class Product < ActiveRecord::Base
	has_many :assets

	has_one :table_specification
	
	belongs_to :factory
	belongs_to :type_furniture

	# validates_presence_of :type_furniture_id, message: "^We need to know who is filling in this form (your name)"
	validates_presence_of :factory
	validates_presence_of :type_furniture

	validates_presence_of :table

	validates :article_id, presence: true, numericality: {only_integer: true}

	accepts_nested_attributes_for :assets

  before_save :default_values
  def default_values
    self.price ||= 0
  end

end
