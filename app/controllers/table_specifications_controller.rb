class TableSpecificationsController < ApplicationController
  # before_action :check_role
  before_action :set_table_specification, only: [:show, :edit, :update, :destroy, :add_photos]
  before_action :set_project_specification
  respond_to :html, :json
  respond_to :html, :js
  autocomplete :product, :article, :extra_data => [:type_furniture_id, :factory_id]

  skip_before_action :verify_authenticity_token
  # GET /table_specifications
  # GET /table_specifications.json
  def index
    # authorize! :index, @table_specification
    @user = current_user
    authorize! :show, @project
    @table_specifications = @specification.table_specifications.all
    @table_specification = TableSpecification.new

    respond_to do |format|
        format.json
        format.html
        format.pdf do 
          pdf = TableSpecificationPdf.new(@project, @specification, @table_specifications, @user)
          send_data pdf.render, filename: "specification_#{@specification.id}.pdf",
                                type: "application/pdf",
                                disposition: "inline"
      end
    end
  end

  def packing_sizes
    @deliveries = Delivery.all
    p params[:id]
    if params[:id]
      table_specification = TableSpecification.find(params[:id])
      @percent_v = table_specification.percent_v
    else
      @percent_v = 10
    end

    if params[:product_id].to_i != 0
      @product = Product.find(params[:product_id])
    else
      @product = Product.new
    end
    
    respond_to do |format|
      format.js
    end
  end

  def deliveries
    @deliveries = Delivery.all
    unless params[:row_id].nil?
      @table_specification = TableSpecification.find(params[:row_id])
    else
      @table_specification = TableSpecification.new
    end
    
    respond_to do |format|
      format.js
    end
  end

  def delivery_data
    p params[:delivery_id]
    @delivery_data = Delivery.find(params[:delivery_id])
      @table_specification = TableSpecification.new

    respond_to do |format|
      format.js
    end
  end

  def update_brand_models
    @brand_models = BrandModel.where("factory_id = ?", params[:factory_id])
    @brand_model = @brand_models.first
    @factory = Factory.find(params[:factory_id])
    @discounts = Discount.where("factory_id = ?", params[:factory_id])
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
    @factories = Factory.all

    product_id = params[:product_id]

    if product_id.to_i != 0
      @product = Product.find(params[:product_id])
      @brand_model = BrandModel.find(@product.brand_model_id)
      @factory = Factory.find(@brand_model.factory_id)
      @brand_models = BrandModel.where(factory: @factory)
      p "-1---"
      p @type_furniture = @product.type_furniture
      p "-1---"

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
        p @br
        p "-2---"
        p product_id
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
        p "-2---"
        # if @type_furniture.nil?
        #   @type_furniture.id = 1
        # end

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

  # GET /table_specifications/1
  # GET /table_specifications/1.json
  def show
    
  end

  # GET /table_specifications/new
  def new
    @table_specification = TableSpecification.new 
    @brand_model = BrandModel.new
    @product = Product.new
    @photo = Photo.new
    
    @factories = Factory.all
    @brand_models = BrandModel.all
    @type_furnitures = TypeFurniture.all
    @articles = Product.all

  end

  # GET /table_specifications/1/edit
  def edit
  end

  # POST /table_specifications
  # POST /table_specifications.json
  def create
    @table_specifications = @specification.table_specifications.all
    @table_specification = @specification.table_specifications.new(table_specification_params)

    if params[:add_photos]
      ts = TableSpecification.find(@table_specification.ts_id)
      product = Product.find(@table_specification.product_id)
      save_img ts, ts.photo_id, product, @table_specification.photo_base64, Photo
    end

    if params[:add_size_images]
      ts = TableSpecification.find(@table_specification.ts_id)
      product = Product.find(@table_specification.product_id)
      save_img ts, ts.size_image_id, product, @table_specification.size_image_base64, SizeImage
    end

    if params[:create_ts]
      @brand_model = BrandModel.new(brand_model_params)
      @product = Product.new(product_params)
      
      respond_to do |format|
        if @table_specification.save
          brand_model = BrandModel.where(name: params[:brand_model][:name]).last

          if brand_model.nil?
            brand_model = BrandModel.new
            brand_model.id = 0
          end 
          # Сценарий если нет ни модели ни продукта
          if brand_model.id == 0
            if @brand_model.save
              if @product.save
                p "+++++++"
                p "+++++++"
                p "+++++++"
                @product.brand_model_id = @brand_model.id
                @product.save
                @table_specification.product_id = @product.id
                @table_specification.save
                
                save_img @table_specification, @table_specification.photo_id, @product, @table_specification.photo_base64_form, Photo
                save_img @table_specification, @table_specification.size_image_id, @product, @table_specification.size_image_base64_form, SizeImage

              end
            end
          else
            # @table_specification = TableSpecification.find()
            product = Product.where(article: params[:product][:article]).last
            p product
            # Сценарий если есть модель но нет продукта
            if product.nil?
              if @product.save
                format.js
                p "---++++"
                p "---++++"
                p "---++++"
                @product.brand_model_id = brand_model.id
                @product.save
                
                @table_specification.product_id = @product.id
                @table_specification.save

                save_img @table_specification, @table_specification.photo_id, @product, @table_specification.photo_base64_form, Photo
                save_img @table_specification, @table_specification.size_image_id, @product, @table_specification.size_image_base64_form, SizeImage
                
              end
            # Сценарий если есть модель и продукт
            else
                p "-------"
                p "-------"
                p "-------"
                save_img @table_specification, @table_specification.photo_id, product, @table_specification.photo_base64_form, Photo
                save_img @table_specification, @table_specification.size_image_id, @product, @table_specification.size_image_base64_form, SizeImage
                
                @table_specification.product_id = product.id
                @table_specification.save
            end 
          end
          format.html { redirect_to project_specification_table_specifications_path, notice: 'Table specification was successfully created.' }
          format.json { render :show, status: :created, location: @table_specification }
          format.js
        else
          format.html { render :index }
          format.json { render json: @table_specification.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # Save photo
  def save_img table_specification, model_id, product, base64, model

    # if model_id.nil? 
      photo = Paperclip.io_adapters.for(base64) 
      photo.original_filename = product.article+'_photo.jpeg'
      @photo = model.new(img: photo)
      if @photo.save
        @photo.product_id = product.id
        @photo.save

        if model == Photo
          table_specification.photo_id = @photo.id
        elsif model == SizeImage
          table_specification.size_image_id = @photo.id
        end
        
        table_specification.save
      end
    # end
  end

  # PATCH/PUT /table_specifications/1
  # PATCH/PUT /table_specifications/1.json
  def update
    respond_to do |format|
      if  @table_specification.update(table_specification_params)
        format.json { head :no_content }
        format.js
      else
        format.json { respond_with_bip(@table_specification) }
      end
    end   
  end

  # DELETE /table_specifications/1
  # DELETE /table_specifications/1.json
  def destroy
    @table_specification.destroy
    respond_to do |format|
      format.html { redirect_to project_specification_table_specifications_path, notice: 'Table specification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    # UPDATE PRINT SUM IN SPECIFICATION 
  def update_print_sum
    # x = Boolean.new
    x = params[:print_sum]
    p x
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table_specification
      @table_specification = TableSpecification.find(params[:id])
    end

    def set_project_specification
      @project = Project.find(params[:project_id])
      @specification = Specification.find(params[:specification_id])      
    end

    def check_role
      @user = current_user
      if (@user.has_role? :admin) || (@user.has_role? :company_moderator) || (@user.has_role? :manager)

      else
        redirect_to main_page_index_path
      end
    end
        # Never trust parameters from the scary internet, only allow the white list through.
    def brand_model_params
      params.require(:brand_model).permit(:name, :factory_id)
    end

    def photo_params
       params.require(:photo).permit(
        :type, 
        :img, 
        :product_id
      )
    end

    def product_params
      params.require(:product).permit(
      :article,
      :price, 
      :weight, 
      :width, 
      :height, 
      :depth, 
      :unit_v,
      :type_furniture_id, 
      :factory_brand, 
      :type_furniture_name, 
      :brand_model_id
      # brand_model_attributes: [:name]
      )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def table_specification_params
      if params[:table_specification].is_a? String
        params[:table_specification]
      else
        params.require(:table_specification).permit(
          :id, 
          :finishing,
          :finishing_for_client,
          :unit_price_factory,
          :increment_discount,
          :size,
          :percent_v, 
          :number_of,
          :interest_percent,
          :arhitec_percent,
          :group,
          :additional_delivery,
          :additional_packaging,
          :required,
          # :packing, 
          # :add_to_delivery,

         
          :specification_id, 
          :factory_brand,
          :factory_id, 
          :discount_id,
          :delivery_id, 
          :asset_id,
          :factory_discount,
          :photo_id,
          :size_image_id,
          :product_id,
          :photo_base64,
          :photo_base64_form,
          :size_image_base64,
          :size_image_base64_form,
          :ts_id
          )
      end
    end
end
