class Specification < ActiveRecord::Base
  belongs_to :project
  has_many :table_specifications, dependent: :destroy
  has_many :table_specification_lights, dependent: :destroy
  has_many :tables, dependent: :destroy

  accepts_nested_attributes_for :table_specifications
  accepts_nested_attributes_for :table_specification_lights
  accepts_nested_attributes_for :tables
  
  validates :name, presence: true, length: {minimum: 2}

  FULL_PERCENT = 100

	COLUMN_SIZE = {
		"photo" 			=> 1.5,
		"factory" 		=> 0.8,
		"brand_model"	=> 0.8,
		"article"			=> 0.8,
		"finishing" 	=> 1.3,
		"description"	=> 1.0,
		"size" 				=> 1.3,
		"upf" 				=> 0.8,
		"sum_factory"	=> 0.8,
		"number_of"		=> 0.1,
		"interest" 		=> 0.8,
		"full_price" 	=> 0.8,
		"full_sum" 		=> 0.8,
		"v" 					=> 0.2,
		"architector" => 0.8
	}

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
					p cs[0]
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
		colspan_sum
		p percent_css_widths
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
		p count
		p after
		p before
		if count == before
			after = 0
			p "-1"
		else
			after = count - before
			p "+1"
		end

		{before: before, after: after}
	end

	def checks_print_size_css checks_to_print
		 # checks_to_print
	end
	
	def orientation sum_pixels
		if sum_pixels > 670
			'Landscape'
		else
			'Portrait'
		end
	end
end
