# encoding: utf-8
class TableSpecificationPdf < Prawn::Document
	
	def initialize(project, specification, table_specifications, user)
		super(margin: 10)
		
		@tables = table_specifications
		# @specification = specification
		@project = project
		@user = user

		# font "#{Rails.root}/app/assets/fonts/Ubuntu-M.ttf"
		font_families.update("Ubuntu" => { :bold => "#{Rails.root}/app/assets/fonts/Ubuntu-B.ttf",
		 								   :normal => "#{Rails.root}/app/assets/fonts/Ubuntu-M.ttf"
		 })
		font_families.update("helvetica-ultra-light" => { :normal => "#{Rails.root}/app/assets/fonts/helvetica-neue-ultra-light.ttf" })
		font_size 8
		header
		manager_info

		# require "open-uri"
		# require "prawn/gmagick"

		if !specification[0]
			@specification  = specification
			rect_specification
			name_specification
			# line_items
			# total_price
		else
			i = 0
			while i < specification.length do
				rect_specification
				@specification = specification[i]
				name_specification
				line_items
				total_price
			i+=1
			end
			total_sum_project
		end
	end

	def header
		font "helvetica-ultra-light"
		text "DIZAAP", size: 50 
		text " \##{@project.id}", size: 30
	end

	def manager_info
		font "Ubuntu"
		text @user.name, size: 10
		text @user.telephone, size: 10
		text @user.email
		move_down 10
	end

	def name_specification
		font "Ubuntu"
		indent(5) do
			text "#{@specification.name}", size: 10
		end
	end

	def rect_specification
		bounding_box([68,cursor], :width => 0, :height => 2) do
	        stroke_color 'FFFFFF'
	        stroke_bounds
	        stroke do
	            stroke_color '000000'
	            fill_color 'CCCCCC'
	            fill_and_stroke_rectangle [cursor-70,cursor], 592, 12
	            fill_color '000000'
	        end
	    end
	end

	def line_items
		move_down 0
		font "Ubuntu", style: :normal

		items = [["Изображение", "Наименование", "Отделка", "Размер", "Цена за 1шт.", "Ко-во", "Сумма"]]
		@specification.tables.each_with_index.map do |item, i|
		
		require "open-uri"
		require "prawn/gmagick"
		
		if item.photo_id
			current_photo = Photo.find(item.photo_id)
			image_photo = open(current_photo.img.url)

		else
			# image = "#{Rails.root}/public/no_image/no_image.png"
		end

		sum = 0
		if item.add_row(@specification)[item.group] > 1
			sum = item.groupDataSum(item.group, "gp_sum_number")
			summa = {content: "#{sum}", rowspan: 2}
		else	
			sum = item.with_interest
			summa = {content: "#{sum}", rowspan: 2}
		end

		unit_price = 0

		if (item.class.name === "TableSpecification")
			unit_price = item.groupDataSum(item.group, "gp_unit_sum")
		elsif (item.class.name === "TableSpecificationLight")
			unit_price = item.unit_with_interest_light
		end
		
		if item.size_image_id
			current_photo = SizeImage.find(item.size_image_id)
			image_size1 = open(current_photo.img.url)
			image_size = {:image => image_size1, image_width: 100, rowspan: 1}
			
			items << [
				{:image => image_photo, image_width: 150, rowspan: 2},
				{content: "#{item.product.article}", rowspan: 2}, 
				{content: "#{item.finishing_for_client}", rowspan: 2}, 
				image_size, 
				{content: "#{unit_price}", rowspan: 2}, 
				{content: "#{item.number_of}", rowspan: 2}, 
				summa
			]
		else
			image_size = {content: "", rowspan: 2}
			items << [
				{:image => image_photo, image_width: 150, rowspan: 1},
				{content: "#{item.product.article}", rowspan: 2}, 
				{content: "#{item.finishing_for_client}", rowspan: 2}, 
				image_size, 
				{content: "#{unit_price}", rowspan: 2}, 
				{content: "#{item.number_of}", rowspan: 2}, 
				summa
			]
			# image_size1 = "#{Rails.root}/public/no_image/no_image.png"
		end
		
		
		# items << [
		# 		{:image => image_photo, image_width: 150, rowspan: 2},
		# 		{content: "#{item.product.article}", rowspan: 2}, 
		# 		{content: "#{item.finishing_for_client}", rowspan: 2}, 
		# 		image_size, 
		# 		{content: "#{unit_price}", rowspan: 2}, 
		# 		{content: "#{item.number_of}", rowspan: 2}, 
		# 		summa
		# 		]
		  	
		items << [ {content: "#{item.size}"},

		  	]
		end
		items += total_price


		table items, :header => true, 
		:column_widths => { 0 => 160, 1 => 68, 2 => 98, 3 => 110, 4 => 60, 5 => 36, 6 => 60}
	end
		
	def total_price
		total_sum = []
		if @specification.print_sum
			if @specification.light
				total_sum = [[{colspan: 5}, "Сумма", {content: "#{TableSpecificationLight::specification_sum_all(@specification)}"}]]
			else
				total_sum = [[{colspan: 5}, "Сумма", {content: "#{TableSpecification::specification_sum_all(@specification)}"}]]
			end
		end
		total_sum
	end

	def total_sum_project
		# total_sum = []
		if @project.print_sum
			data = [[{colspan: 1}, "Сумма проекта", {content: "#{Project::sum_specifications(@project.specifications)}"}]]
			table(data, :column_widths => {0=>436, 1=>96, 2=>60})
		end
	end

	def temp
		"#{@specification.table_specifications.each do |i|
			i.article
		end}"
	end
end
