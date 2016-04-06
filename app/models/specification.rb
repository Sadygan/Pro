class Specification < ActiveRecord::Base
  belongs_to :project
  has_many :table_specifications, dependent: :destroy
  has_many :table_specification_lights, dependent: :destroy
  has_many :tables, dependent: :destroy

  accepts_nested_attributes_for :table_specifications
  accepts_nested_attributes_for :table_specification_lights
  accepts_nested_attributes_for :tables
  
  validates :name, presence: true, length: {minimum: 2}

  before_save :default_values

  FULL_PERCENT = 100

	COLUMN_SIZE = {
		"photo" 		=> 1.5,
		"factory" 		=> 0.7,
		"brand_model"	=> 0.7,
		"article"		=> 0.7,
		"finishing" 	=> 1.3,
		"description"	=> 1.0,
		"size" 			=> 1.4,
		"upf" 			=> 0.6,
		"sum_factory"	=> 0.6,
		"number_of"		=> 0.1,
		"interest" 		=> 0.6,
		"full_price" 	=> 0.6,
		"full_sum" 		=> 0.6,
		"v" 			=> 0.1,
		"photo_px" 		=> 0,
		"size_px" 		=> 0
	}

	def default_values
		self.photo 		 ||= true
		self.brand_model ||= true 
		self.finishing 	 ||= true
		self.description ||= true
		self.size 		 ||= true 
		self.number_of 	 ||= true 
		self.full_price  ||= true 
		self.full_sum 	 ||= true 
	end

	def checks_print_arr_size_factor column_size
		arr_size_factor = []
		arr_size_name = []
		try_list = {}
		self.attributes.map do |cs|
			if column_size.include?(cs[0])
				if cs[1] == true
					arr_size_factor.push(column_size[cs[0]])
					arr_size_name.push(column_size[cs[1]])
					try_list[cs[0]] = column_size[cs[0]]
					column_size.include?(cs[0])
				end
			end
		end
		try_list
	end

  def checks_print_count
  	checks_print_arr_size_factor(COLUMN_SIZE).count
  end

  def sum_pixels
		sum_pixel = 0
		checks_print_arr_size_factor(COLUMN_SIZE).each do |i|
			sum_pixel += i[1] * 100
		end
		sum_pixel
	end

	def percent_css_width
		percent_css_widths = {}
		checks_print_arr_size_factor(COLUMN_SIZE).each do |i|
			percent_css_widths[i[0]] = (i[1] * 10000 / sum_pixels).round(3)
		end
		p "-----><><"
		p percent_css_widths["photo_x"]
		percent_css_widths["photo_px"] = sum_pixels * percent_css_widths["photo"].to_i / 100
		percent_css_widths["size_px"] = sum_pixels * percent_css_widths["size"].to_i / 100
	end

	def colspan_sum
		count = checks_print_arr_size_factor(COLUMN_SIZE).count-1 
		before = 0
		after = 0
		checks_print_arr_size_factor(COLUMN_SIZE).each do |i|
			if i[0] != "full_sum"
				before = before+1
			else
				break
			end
		end
		if count == before
			after = 0
		else
			after = count - before
		end

		{before: before, after: after}
	end

	def orientation sum_pixels
		if sum_pixels > 670
			'Landscape'
		else
			'Portrait'
		end
	end
end
