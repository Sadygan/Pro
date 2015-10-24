class TableSpecificationLightsController < ApplicationController
  before_action :set_table_specification_light, only: [:show, :edit, :update, :destroy]
  before_action :set_project_specification
  respond_to :html, :json
  respond_to :html, :js
  autocomplete :product, :article, :extra_data => [:type_furniture_id, :factory_id]

  # GET /table_specification_lights
  # GET /table_specification_lights.json
  def index
    @table_specification_lights = TableSpecificationLight.all
  end

  # GET /table_specification_lights/1
  # GET /table_specification_lights/1.json
  def show
  end

  # GET /table_specification_lights/new
  def new
    @table_specification_light = TableSpecificationLight.new
  end

  # GET /table_specification_lights/1/edit
  def edit
  end

  # POST /table_specification_lights
  # POST /table_specification_lights.json
  def create
    @table_specification_light = TableSpecificationLight.new(table_specification_light_params)

    respond_to do |format|
      if @table_specification_light.save
        format.html { redirect_to project_specification_table_specification_lights_path, notice: 'Table specification light was successfully created.' }
        format.json { render :show, status: :created, location: @table_specification_light }
        format.js
      else
        format.html { render :new }
        format.json { render json: @table_specification_light.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /table_specification_lights/1
  # PATCH/PUT /table_specification_lights/1.json
  def update
    respond_to do |format|
      if @table_specification_light.update(table_specification_light_params)
        format.html { redirect_to @table_specification_light, notice: 'Table specification light was successfully updated.' }
        format.json { render :show, status: :ok, location: @table_specification_light }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @table_specification_light.errors, status: :unprocessable_entity }
        format.js
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

        # Never trust parameters from the scary internet, only allow the white list through.
    def table_specification_light_params
      params.require(:table_specification_light).permit(
        :finishing,
        :finishing_for_client,
        :unit_price_factory,
        # :width,
        # :height,
        # :depth,
        :number_of,
        :interest_percent,
        :arhitec_percent,

        :specification_id, 
        :factory_brand,
        :factory_id, 
        :discount_id,
        :delivery_id, 
        :asset_id,
        :photo_id,
        :size_image_id,
        :product_id
        )
    end
end
