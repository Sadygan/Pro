class PhotosController < ApplicationController
  # before_action :check_role
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_product

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.where(product_id: @product)
    
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create    
    @photo = Photo.new(photo_params)
    @photo.product_id = @product.id

    respond_to do |format|
      if @photo.save
        format.html { render 'crop' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.send model_update_method, photo_params
        format.html { redirect_to @product, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to @product, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /photos/1/crop
  # POST /photos/1/crop.json
  def crop
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def check_role
      @user = current_user
      if (@user.has_role? :admin) || (@user.has_role? :company_moderator) || (@user.has_role? :manager)

      else
        redirect_to main_page_index_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
       params.require(:photo).permit(
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

    def model_update_method
      Rails::VERSION::MAJOR == 4 ? :update : :update_attributes
    end

end