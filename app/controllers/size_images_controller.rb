class SizeImagesController < ApplicationController
  # before_action :check_role
  before_action :set_size_image, only: [:show, :edit, :update, :destroy]
  before_action :set_product
  # GET /size_images
  # GET /size_images.json
  def index
    @size_images = SizeImage.where(product_id: @product)
  end

  # GET /size_images/1
  # GET /size_images/1.json
  def show
  end

  # GET /size_images/new
  def new
    @size_image = SizeImage.new
  end

  # GET /size_images/1/edit
  def edit
  end

  # POST /size_images
  # POST /size_images.json
  def create
    @size_image = SizeImage.new(size_image_params)
    @size_image.product_id = @product.id

    respond_to do |format|
      if @size_image.save
        format.html { render 'crop' }
        format.json { render :show, status: :created, location: @size_image }
      else
        format.html { render :new }
        format.json { render json: @size_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /size_images/1
  # PATCH/PUT /size_images/1.json
  def update
    respond_to do |format|
      if @size_image.send model_update_method, size_image_params
        format.html { redirect_to @product, notice: 'Size image was successfully updated.' }
        format.json { render :show, status: :ok, location: @size_image }
      else
        format.html { render :edit }
        format.json { render json: @size_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /size_images/1
  # DELETE /size_images/1.json
  def destroy
    @size_image.destroy
    respond_to do |format|
      format.js
      format.json { head :no_content }
    end
  end

  # POST /size_images/1/crop
  # POST /size_images/1/crop.json
  def crop
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_size_image
      @size_image = SizeImage.find(params[:id])
    end

    # Never trust parameters from the scary inteparams[:size_image]the white list through.
    def size_image_params
      params.require(:size_image).permit(
        :type, 
        :img, 
        :product_id, 
        :img_original_w, 
        :img_original_h, 
        :img_box_w, 
        :img_aspect, 
        :img_crop_x, 
        :img_crop_y, 
        :img_crop_w, 
        :img_crop_h
      )
    end

    def check_role
      @user = current_user
      if (@user.has_role? :admin) || (@user.has_role? :company_moderator) || (@user.has_role? :manager)

      else
        redirect_to main_page_index_path
      end
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def model_update_method
      Rails::VERSION::MAJOR == 4 ? :update : :update_attributes
    end
end
