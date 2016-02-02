class TableSpecificationLightsController < ApplicationController
  # before_action :check_role
  before_action :set_table_specification_light, only: [:show, :edit, :update, :destroy]
  before_action :set_project_specification

  # GET /table_specification_lights
  # GET /table_specification_lights.json
  def index
    # authorize! :index, @table_specification
    @user = current_user
    authorize! :show, @project
    # @table_specification_lights = TableSpecificationLight.all
    # @table_specification_lights = @specification.table_specification_lights.all
    @table_specification_lights = @specification.table_specification_lights.all

        respond_to do |format|
          format.json
          format.html
          format.pdf do 
            pdf = TableSpecificationPdf.new(@project, @specification, @table_specification_lights, @user)
            send_data pdf.render, filename: "specification_#{@specification.id}.pdf",
                                  type: "application/pdf",
                                  disposition: "inline"
        end
      end
  end

  # GET /table_specification_lights/1
  # GET /table_specification_lights/1.json
  def show
  end

  # GET /table_specification_lights/new
  def new
    @table_specification_light = TableSpecificationLight.new
    @brand_model = BrandModel.new
    @product = Product.new
    @photo = Photo.new
    
    @factories = Factory.all
    @brand_models = BrandModel.all
    @type_furnitures = TypeFurniture.all
    @articles = Product.all
  end

  # GET /table_specification_lights/1/edit
  def edit
  end

  # POST /table_specification_lights
  # POST /table_specification_lights.json
  def create
    @table_specification_lights = @specification.table_specifications.all
    @table_specification_light = @specification.table_specification_lights.new(table_specification_light_params)

    if params[:add_photos]
      ts = TableSpecification.find(@table_specification_light.ts_id)
      product = Product.find(@table_specification_light.product_id)
      save_img ts, ts.photo_id, product, @table_specification_light.photo_base64, Photo
    end

    if params[:add_size_images]
      ts = TableSpecification.find(@table_specification_light.ts_id)
      product = Product.find(@table_specification_light.product_id)
      save_img ts, ts.size_image_id, product, @table_specification_light.size_image_base64, SizeImage
    end

    if params[:create_ts]
      @brand_model = BrandModel.new(brand_model_params)
      @product = Product.new(product_params)
      
      respond_to do |format|
        if @table_specification_light.save
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
                @table_specification_light.product_id = @product.id
                @table_specification_light.save
                
                save_img @table_specification_light, @table_specification_light.photo_id, @product, @table_specification_light.photo_base64_form, Photo
                save_img @table_specification_light, @table_specification_light.size_image_id, @product, @table_specification_light.size_image_base64_form, SizeImage

              end
            end
          else
            # @table_specification_light = TableSpecification.find()
            product = Product.where(article: params[:product][:article]).last
            p "->>>>"
            p params[:product][:id]
            p product
            # Сценарий если есть модель но нет продукта
            if product.nil?
              if @product.save
                p "---++++"
                p "---++++"
                p "---++++"
                @product.brand_model_id = brand_model.id
                @product.save
                
                @table_specification_light.product_id = @product.id
                @table_specification_light.save

                save_img @table_specification_light, @table_specification_light.photo_id, @product, @table_specification_light.photo_base64_form, Photo
                save_img @table_specification_light, @table_specification_light.size_image_id, @product, @table_specification_light.size_image_base64_form, SizeImage
                
              end
            # Сценарий если есть модель и продукт
            else
                p "-------"
                p "-------"
                p "-------"
                save_img @table_specification_light, @table_specification_light.photo_id, product, @table_specification_light.photo_base64_form, Photo
                save_img @table_specification_light, @table_specification_light.size_image_id, @product, @table_specification_light.size_image_base64_form, SizeImage
                
                @table_specification_light.product_id = product.id
                @table_specification_light.save
            end 
          end
          format.html { redirect_to project_specification_table_specification_lights_path, notice: 'Table specification was successfully created.' }
          format.json { render :show, status: :created, location: @table_specification_light }
          format.js
        else
          format.html { render :index }
          format.json { render json: @table_specification_light.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /table_specification_lights/1
  # PATCH/PUT /table_specification_lights/1.json
  def update
    respond_to do |format|
      if @table_specification_light.update(table_specification_light_params)
        format.json { head :no_content }
        format.js
      else
        format.json { respond_with_bip(@table_specification_light) }
      end
    end
  end

  # DELETE /table_specification_lights/1
  # DELETE /table_specification_lights/1.json
  def destroy
    @table_specification_light.destroy
    respond_to do |format|
      format.html { redirect_to table_specification_lights_url, notice: 'Table specification light was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_table_specification_light
    @table_specification_light = TableSpecificationLight.find(params[:id])
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
  def table_specification_light_params
    if params[:table_specification].is_a? String
      params[:table_specification]
    else
      params.require(:table_specification_light).permit(
        :finishing,
        :finishing_for_client,
        :unit_price_factory,
        :size,
        # :width,
        # :height,
        # :depth,
        :number_of,
        :interest_percent,
        :arhitec_percent,

        :specification_id, 
        :factory_brand,
        :factory_id, 
        :photo_id,
        :size_image_id,
        :product_id,
        :photo_base64_form,
        :size_image_base64_form
        )
    end
  end

  def brand_model_params
    params.require(:brand_model).permit(:name, :factory_id)
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
    )
  end
end
