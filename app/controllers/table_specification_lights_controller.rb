class TableSpecificationLightsController < ApplicationController
  before_action :check_role
  before_action :set_table_specification_light, only: [:show, :edit, :update, :destroy]
  before_action :set_project_specification
  respond_to :html, :json
  respond_to :html, :js
  autocomplete :product, :article, :extra_data => [:type_furniture_id, :factory_id]

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
  end

  # GET /table_specification_lights/1/edit
  def edit
  end

  # POST /table_specification_lights
  # POST /table_specification_lights.json
  def create
    @table_specification_light = @specification.table_specification_lights.create(table_specification_light_params)

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
          :product_id)
      end
    end
end
