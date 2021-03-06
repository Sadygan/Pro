 class Tables::GeneralMethodsController < ApplicationController
      # UPDATE PRINT SUM IN SPECIFICATION 
  def update_print_sum
    @specification = Specification.find(params[:specification_id])
    @specification.print_sum = params[:print_sum]
    respond_to do |format|
      if @specification.save
       format.json { head :no_content }
       format.js
      else
        format.json { respond_with_bip(@table_specification) }
      end
    end
  end
  
  def update_brand_models
    @brand_models = BrandModel.where("factory_id = ?", params[:factory_id])
    @brand_model = @brand_models.first
    @factory = Factory.find(params[:factory_id])
    p "_____>>>"
    @discounts = Discount.where("factory_id = ?", params[:factory_id])
    @discount_lights = DiscountLight.where(factory_id: params[:factory_id]) 
    @discount = @discounts.first

    respond_to do |format|
      format.js
    end
  end

  def discounts
    @discounts = Discount.where("factory_id = ?", params[:factory_id])
    @factory = @discounts.first.factory
    unless params[:row_id].nil?
      @table_specification = TableSpecification.find(params[:row_id])
    else
      @table_specification = TableSpecification.new
    end
    respond_to do |format|
      format.js
    end
  end

  def update_articles
    @products = Product.where("brand_model_id = ?", params[:brand_model_id])
    respond_to do |format|
      format.js
    end
  end

  def update_pipe_article
    @photos = Photo.where("product_id = ?", params[:product_id])
    @photo = @photos.first
    @size_images = SizeImage.where("product_id = ?", params[:product_id])
    @size_image = @size_images.first
    
    @type_furnitures = TypeFurniture.all
    @factories = Factory.filter_list_light
    product_id = params[:product_id]
    if product_id.to_i != 0
      @product = Product.find(params[:product_id])
      @brand_model = BrandModel.find(@product.brand_model_id)
      @factory = Factory.find(@brand_model.factory_id)
      @brand_models = BrandModel.where(factory: @factory)
      p @type_furniture = @product.type_furniture
    else
      brand_model_id = params[:brand_model_id]
      if @brand_model.to_i != 0
        @brand_model = BrandModel.find(params[:brand_model_id])
        @factory = Factory.find(@brand_model.factory_id)
      else
        @factory = Factory.find(params[:factory_id])
        @brand_models = BrandModel.where(factory_id: @factory)
        @brand_model = BrandModel.new()
        @brand_model.id = params[:brand_model_id]
        @br = @brand_model.name = params[:brand_model_val]
        if product_id.to_i != 0
          @product = Product.find(product_id)
        else
          @product = Product.new(width: 0, height: 0, depth: 0)
        end
        if params[:type_furniture] != nil
          @type_furniture = TypeFurniture.find(params[:type_furniture])
        else
          @type_furniture = TypeFurniture.first
        end 
      end
    end
    @discounts = Discount.where("factory_id = ?", @factory)
    @discount = @discounts.first
    
    respond_to do |format|
      format.js
    end
  end

  def photos
    @photos = Photo.where("product_id = ?", params[:product_id])
    p @photos
    respond_to do |format|
      format.js
    end
  end

  def size_images
    @size_images = SizeImage.where("product_id = ?", params[:product_id])
    respond_to do |format|
      format.js
    end
  end

  def required
    @table = Table.find(params[:row_id])
    @table.required = params[:required]
    respond_to do |format|
      if @table.save
       format.json { head :no_content }
       format.js
      else
        format.json { respond_with_bip(@table_specification) }
      end
    end
  end

  def check_column
    specification = Specification.find(params[:specification_id])
    @id = params[:id]
    
    case params[:value]
      when "photo" 
        @specification_value = specification.photo        = params[:required]
      when "factory" 
        @specification_value = specification.factory      = params[:required]
      when "brand_model" 
        @specification_value = specification.brand_model  = params[:required]
      when "article" 
        @specification_value = specification.article      = params[:required]
      when "finishing" 
        @specification_value = specification.finishing    = params[:required]
      when "description" 
        @specification_value = specification.description  = params[:required]
      when "size" 
        @specification_value = specification.size         = params[:required]
      when "upf" 
        @specification_value = specification.upf          = params[:required]
      when "sum_factory" 
        @specification_value = specification.sum_factory  = params[:required]
      when "number_of" 
        @specification_value = specification.number_of    = params[:required]                                                                
      when "interest" 
        @specification_value = specification.interest     = params[:required]                                                                
      when "full_price" 
        @specification_value = specification.full_price   = params[:required]                                                                
      when "full_sum" 
        @specification_value = specification.full_sum     = params[:required]                                                                
      when "v" 
        @specification_value = specification.v            = params[:required]                                                                
      when "note" 
        @specification_value = specification.note         = params[:required]                                                               
      when "architector" 
        @specification_value = specification.architector  = params[:required]
    end

    respond_to do |format|
      if specification.save
        format.json { head :no_content }
        format.js
      else
        format.json { respond_with_bip(@specification) }
      end    
    end
  end
end