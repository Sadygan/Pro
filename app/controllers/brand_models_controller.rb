class BrandModelsController < ApplicationController
  before_action :set_brand_model, only: [:show, :edit, :update, :destroy]

  # GET /brand_models
  # GET /brand_models.json
  def index
    @brand_models = BrandModel.all
  end

  # GET /brand_models/1
  # GET /brand_models/1.json
  def show
  end

  # GET /brand_models/new
  def new
    @brand_model = BrandModel.new
  end

  # GET /brand_models/1/edit
  def edit
  end

  # POST /brand_models
  # POST /brand_models.json
  def create
    @brand_model = BrandModel.new(brand_model_params)

    respond_to do |format|
      if @brand_model.save
        format.html { redirect_to @brand_model, notice: 'Brand model was successfully created.' }
        format.json { render :show, status: :created, location: @brand_model }
      else
        format.html { render :new }
        format.json { render json: @brand_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brand_models/1
  # PATCH/PUT /brand_models/1.json
  def update
    respond_to do |format|
      if @brand_model.update(brand_model_params)
        format.html { redirect_to @brand_model, notice: 'Brand model was successfully updated.' }
        format.json { render :show, status: :ok, location: @brand_model }
      else
        format.html { render :edit }
        format.json { render json: @brand_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brand_models/1
  # DELETE /brand_models/1.json
  def destroy
    @brand_model.destroy
    respond_to do |format|
      format.html { redirect_to brand_models_url, notice: 'Brand model was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand_model
      @brand_model = BrandModel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brand_model_params
      params.require(:brand_model).permit(:name)
    end
end
