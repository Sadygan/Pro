class Product < ActiveRecord::Base
  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query
    ]
  )

  # default for will_paginate
  self.per_page = 10

  has_many :assets
  
  before_save :default_values

	belongs_to :factory
	belongs_to :type_furniture
	belongs_to :brand_model
	
  has_many :table_specifications

  validates_presence_of :type_furniture

  validates :article, presence: true
 #  validates :factory_id, presence: true
	# validates :brand_model_name, presence: true
  # validates :width, numericality: true, presence: true
  # validates :height, numericality: true, presence: true
  # validates :depth, numericality: true, presence: true
#  validates :price, numericality: true, presence: true

	accepts_nested_attributes_for :assets
  
  scope :search_query, lambda { |query|
    # Searches the students table on the 'first_name' and 'last_name' columns.
    # Matches using LIKE, automatically appends '%' to each term.
    # LIKE is case INsensitive with MySQL, however it is case
    # sensitive with PostGreSQL. To make it work in both worlds,
    # we downcase everything.
    return nil  if query.blank?
    p "--->"
    p query
    query = query.to_s

    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)

    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conds = 2
    where(
      terms.map { |term|
        "(LOWER(products.article) LIKE ? OR LOWER(products.article) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :with_brand_model_id, lambda { |brand_model_ids|
    where(brand_model_id: [*brand_model_ids])
  }
 

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("products.created_at #{ direction }")
    when /^article_/
      order("LOWER(products.article) #{ direction }")
    when /^brand_model_name_/
      order("LOWER(brand_models.name) #{ direction }").includes(:brand_model)
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.options_for_sorted_by
    [
      ['Article (a-z)', 'article_asc'],
      ['Registration date (newest first)', 'created_at_desc'],
      ['Registration date (oldest first)', 'created_at_asc'],
      ['Brand (a-z)', 'brand_model_name_asc']
    ]
  end


  attr_accessor :photo_base64_form,
                :size_image_base64_form,
                :brand_model_name,
                :factory_id

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
