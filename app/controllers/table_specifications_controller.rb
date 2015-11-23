class TableSpecificationsController < ApplicationController
  # before_action :check_role
  before_action :set_table_specification, only: [:show, :edit, :update, :destroy]
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

  # GET /table_specifications/1
  # GET /table_specifications/1.json
  def show
    
  end

  # GET /table_specifications/new
  def new
    @table_specification = TableSpecification.new 
  end

  # GET /table_specifications/1/edit
  def edit
  end



  # POST /table_specifications
  # POST /table_specifications.json
  def create
    @table_specification = @specification.table_specifications.create(table_specification_params)

    @table_specifications = @specification.table_specifications.all

    respond_to do |format|
      if @table_specification.save
        format.html { redirect_to project_specification_table_specifications_path, notice: 'Table specification was successfully created.' }
        format.json { render :show, status: :created, location: @table_specification }
        format.js
      else
        format.html { render :index }
        format.json { render json: @table_specification.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def set_discount_value
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
          :weight, 
          :width, 
          :height, 
          :depth, 
          :percent_v, 
          :unit_v,
          :number_of,
          :interest_percent,
          :arhitec_percent,
          :group,
          :additional_delivery,
          :required,
         
          :specification_id, 
          :factory_brand,
          :factory_id, 
          :discount_id,
          :delivery_id, 
          :asset_id,
          :factory_discount,
          :photo_id,
          :size_image_id,
          :product_id)
      end
    end
end
