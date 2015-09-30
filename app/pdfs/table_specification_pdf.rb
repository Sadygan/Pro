# encoding: utf-8
class TableSpecificationPdf < Prawn::Document
	
	def initialize(project ,specification, table_specifications)
		super(margin: 10)
		
		@table_specifications = table_specifications
		@project = project
		# font "#{Rails.root}/app/assets/fonts/Ubuntu-M.ttf"
		font_families.update("Ubuntu" => { :bold => "#{Rails.root}/app/assets/fonts/Ubuntu-B.ttf",
		 								   :normal => "#{Rails.root}/app/assets/fonts/Ubuntu-M.ttf"
		 })
		font_families.update("helvetica-ultra-light" => { :normal => "#{Rails.root}/app/assets/fonts/helvetica-neue-ultra-light.ttf" })
		font_size 8
		header
		
		if !specification[1]
			@specification  = specification
			rect_specification
			name_specification
			line_items
			total_price
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
		end
	end

	def header
		font "helvetica-ultra-light"
		text "DIZAAP", size: 50 
		text " \##{@project.id}", size: 30
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
		table line_items_rows do
			rows(0).style = :bold
			rows(0).size = 10
			columns(1..3).align = :center
			columns(1..3).width = 100
			columns(4).width = 45
			columns(5).width = 27
			columns(6).width = 60
			# self.row_colors = ["DDDDDD", "FFFFFF"]
			self.header = true
		end
	end

	def line_items_rows
		[["Изображение", "Наименование", "Отделка", "Размер", "Цена за 1шт.", "Ко-во", "Сумма"]] +
			@specification.table_specifications.map do |item|

				if item.image.path
					image = Rails.root + "#{item.image.path(:medium)}"	
				else
					image = "#{Rails.root}/public/images/original/missing.png"
				end

				[{:image => image, image_width: 150}, item.type_fyrniture, item.finishing_for_client, item.size, item.unit_price, item.number_of, item.summ]
			end
	end

	def total_price
		move_down 4
		if (@specification.print_sum)
			text "Сумма:  #{@specification.summ}", size: 14, align: :right 
		end
		move_down 8
	end

	def temp
		"#{@specification.table_specifications.each do |i|
			i.article
		end}"
	end
end
