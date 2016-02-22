class ProductsController < ApplicationController
  # before_action :check_role
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  autocomplete :type_furniture, :name, :full => true
  autocomplete :factory, :brand, :full => true
  respond_to :html, :json

  # GET /products
  # GET /products.json
  def index
    # @products = Product.all
    @products = Product.paginate(:page => params[:page]).per_page(5)
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
    
    @brand_model = @product.brand_model
    @product.brand_model_name = @brand_model.name
    @product.factory_id = @brand_model.factory_id

    @factories = Factory.all
    @brand_models = BrandModel.all
    @photos = Photo.where(product_id: @product.id)
    @size_images = SizeImage.where(product_id: @product.id)
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    brand_model = BrandModel.where(name: @product.brand_model_name).last
    
    @product.photo_base64_form
    photos_split =  @product.photo_base64_form.split('.')
    size_images_split =  @product.size_image_base64_form.split('.')

    respond_to do |format|
      if @product.save && brand_model.nil?
        @brand_model = BrandModel.new(name: @product.brand_model_name, factory_id: @product.factory_id)
        if @brand_model.save
          if @product.save
            @product.brand_model_id = @brand_model.id
            @product.save
            for i in photos_split
              save_img @product, i, Photo
            end
            for i in size_images_split
              save_img @product, i, SizeImage
            end
            
            format.json { head :no_content }
            format.js
          else
            format.json { render json: @product.errors.full_messages,
                                        status: :unprocessable_entity }
          end
        end
      elsif @product.save && brand_model.present?
        for i in photos_split
          save_img @product, i, Photo
        end
        
        for i in size_images_split
          save_img @product, i, SizeImage
        end      
        @product.brand_model_id = brand_model.id
        @product.save

        format.json { head :no_content }
        format.js 

      else  
          format.json { render json: @product.errors.full_messages,
                                      status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product_ = Product.new(product_params)
    brand_model = BrandModel.where(name: @product.brand_model_name).last
    
    p brand_model

    photos_split = @product_.photo_base64_form.split('.')
    size_images_split =  @product_.size_image_base64_form.split('.')
    p "before"
    p @product

    respond_to do |format|
      if @product.update(product_params) && brand_model.nil?
        p "after"
        p @product
        @brand_model = BrandModel.new(name: @product.brand_model_name, factory_id: @product.factory_id)
        p @brand_model
        if @brand_model.save
          @product.brand_model_id = @brand_model.id
          p "------->"
          p @brand_model
          for i in photos_split
            save_img @product, i, Photo
          end
          for i in size_images_split
            save_img @product, i, SizeImage
          end
          
          format.json { head :no_content }
          format.js 
        else
          format.json { render json: 'brand_model',
                                    status: :unprocessable_entity }           
        end
      elsif @product.update(product_params) && brand_model.present?
        for i in photos_split
          save_img @product, i, Photo
        end
        for i in size_images_split
          save_img @product, i, SizeImage
        end
        format.json { head :no_content }
        format.js            
      else
        format.json { render json: @product.errors.full_messages,
                                    status: :unprocessable_entity } 
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
    # if model_id.nil? 
      photo = Paperclip.io_adapters.for(base64) 
      photo.original_filename = product.article+'_photo.jpeg'
      @photo = model.new(img: photo)
      if @photo.save
        @photo.product_id = product.id
        @photo.save
      else

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

  def brand_model_params
    params.require(:brand_model).permit(:id,:name, :factory_id)
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
      :photo_base64_form,
      :size_image_base64_form,
      :factory_id, 
      :brand_model_name

      # :factory_brand, 
      # :type_furniture_name
      )
  end
end
