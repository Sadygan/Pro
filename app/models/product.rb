class Product < ActiveRecord::Base

  filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
              :available_filters => %w[
                sorted_by
                search_query
                with_brand_model_id
                with_factory_id
                with_type_furniture_id
              ]

  # default for will_paginate
  self.per_page = 10

  belongs_to :brand_model, -> { includes :factory }
  belongs_to :type_furniture
 
  scope :search_query, lambda { |query|
    # Searches the students table on the 'first_name' and 'last_name' columns.
    # Matches using LIKE, automatically appends '%' to each term.
    # LIKE is case INsensitive with MySQL, however it is case
    # sensitive with PostGreSQL. To make it work in both worlds,
    # we downcase everything.
    return nil  if query.blank?

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

  scope :sorted_by, lambda { |sort_option|
    p "--->"
    p sort_option
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("products.created_at #{ direction }")
    when /^article_/
      order("LOWER(products.article) #{ direction }")
    when /^brand_model_/
      order("brand_models.name #{ direction }").includes(:brand_model)
    when /^factory_/
      order("factories.brand #{ direction }").includes(:brand_model => :factory)
    when /^type_furniture_/
      order("type_furnitures.name #{ direction }").includes(:type_furniture)
    when /^price_/
      order("products.price #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_brand_model_id, lambda { |brand_model_ids|
    where(brand_model_id: [*brand_model_ids])
  }

  scope :with_type_furniture_id, lambda { |type_furniture_ids|
    where(type_furniture_id: [*type_furniture_ids])
  }

  scope :with_factory_id, lambda { |factory_ids|
    joins(:brand_model).where(brand_models: {factory_id: [*factory_ids]})
  }


  def self.options_for_sorted_by
    [
      ['Артикул (a-z)', 'article_asc'],
      ['Новые первые', 'created_at_desc'],
      ['Последние первые', 'created_at_asc'],
      ['Модель (a-z)', 'brand_model_name_asc'],
      ['Фабрика (a-z)', 'factory_brand_asc']
    ]
  end
  has_many :table_specifications
  has_many :assets

  before_save :default_values

  # validates_presence_of :type_furniture

  validates :article, presence: true
 
  # validates :width, numericality: true, presence: true
  # validates :height, numericality: true, presence: true
  # validates :depth, numericality: true, presence: true
#  validates :price, numericality: true, presence: true

  accepts_nested_attributes_for :assets

  attr_accessor :photo_base64_form,
                :size_image_base64_form,
                :brand_model_name,
                :factory_id

  # validates :factory_id, presence: true
  # validates :brand_model_name, presence: true

  # def validate!
  #   errors.add(:factory_id, "cannot be nil") if factory_id == ""
  # end
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
