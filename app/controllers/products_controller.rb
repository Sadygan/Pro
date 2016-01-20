class ProductsController < ApplicationController
  # before_action :check_role
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  autocomplete :type_furniture, :name, :full => true
  autocomplete :factory, :brand, :full => true
  respond_to :html, :json

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @photo = Photo.new
    @photos = Photo.where(product_id: @product)

    @size_image = SizeImage.new
    @size_images = SizeImage.where(product_id: @product)
  end

  # GET /products/new
  def new
    @product = Product.new
    @brand_model = BrandModel.new

    @factories = Factory.all
    @brand_models = BrandModel.all
    @type_furnitures = TypeFurniture.all
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    brand_model = BrandModel.where(name: params[:brand_model][:name]).last
    # photo_split =  @product.photo_base64_form.split(',')

    respond_to do |format|
      if brand_model.nil?
        @brand_model = BrandModel.new(brand_model_params)
          if @brand_model.save
            if @product.save
              @product.brand_model_id = @brand_model.id
              @product.save
              format.json { head :no_content }
              format.js
            else
              format.json { render json: @style.errors.full_messages,
                                         status: :unprocessable_entity }
            end
        format.js
        end          
      else
        @brand_model = BrandModel.new(brand_model_params)
        if @brand_model.save
          if @product.save
              @product.brand_model_id = brand_model.id
              @product.save

              format.json { head :no_content }
              format.js
            else
              format.json { render json: @style.errors.full_messages,
                                         status: :unprocessable_entity }
            end
        end
        format.js
      end
    end

  end
  
# может даже прибить
  # def create_img
  #   @product = Product.last
  #   p '--->'
  #   p product = Product.find(params[:product_last_id])

  #   save_img product, params[:image_base64], Photo


  #   respond_to do |format|
      
  #     format.json { head :no_content }
  #   end

  # end

  def brand_model_params
    params.require(:brand_model).permit(:name, :factory_id)
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_brand_models
    @brand_models = BrandModel.where("factory_id = ?", params[:factory_id])
    @brand_model = @brand_models.first
    p params[:factory_id]
    @factory = Factory.find(params[:factory_id])


    respond_to do |format|
      format.js
    end
  end
  
  private
    # Save photo
    def save_img product, base64, model
      p "--->"
      p base64
      
      # if model_id.nil? 
        photo = Paperclip.io_adapters.for(base64) 
        photo.original_filename = product.article+'_photo.jpeg'
        @photo = model.new(img: photo)
        if @photo.save
          @photo.product_id = product.id
          p '==>'
          @photo.save
        else
          p '--==>'

        end
      # end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
    
    def check_role
      @user = current_user
      if (@user.has_role? :admin) || (@user.has_role? :company_moderator) || (@user.has_role? :manager)

      else
        redirect_to main_page_index_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(
        :article, 
        :price,
        :weight, 
        :width, 
        :height, 
        :depth, 
        :unit_v, 
        :brand_model_id, 
        :type_furniture_id, 
        :photo_base64_form
        # :factory_brand, 
        # :type_furniture_name
        )
    end
end
