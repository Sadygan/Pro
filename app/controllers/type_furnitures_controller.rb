class TypeFurnituresController < ApplicationController
  # before_action :check_role
  before_action :set_type_furniture, only: [:show, :edit, :update, :destroy]
  
  # GET /type_furnitures
  # GET /type_furnitures.json
  def index
    @type_furnitures = TypeFurniture.all
  end

  # GET /type_furnitures/1
  # GET /type_furnitures/1.json
  def show
  end

  # GET /type_furnitures/new
  def new
    @type_furniture = TypeFurniture.new
  end

  # GET /type_furnitures/1/edit
  def edit
  end

  # POST /type_furnitures
  # POST /type_furnitures.json
  def create
    @type_furniture = TypeFurniture.new(type_furniture_params)

    respond_to do |format|
      if @type_furniture.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @type_furniture.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /type_furnitures/1
  # PATCH/PUT /type_furnitures/1.json
  def update
    respond_to do |format|
      if @type_furniture.update(type_furniture_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @type_furniture.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  # DELETE /type_furnitures/1
  # DELETE /type_furnitures/1.json
  def destroy
    @type_furniture.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to type_furnitures_url, notice: 'Type furniture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_furniture
      @type_furniture = TypeFurniture.find(params[:id])
    end

    def check_role
      @user = current_user
      if (@user.has_role? :admin) || (@user.has_role? :company_moderator)

      else
        redirect_to main_page_index_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_furniture_params
      params.require(:type_furniture).permit(:name)
    end
end
