class DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:show, :edit, :update, :destroy]
  before_action :check_role

  # GET /deliveries
  # GET /deliveries.json
  def index
    @deliveries = Delivery.all
  end

  # GET /deliveries/1
  # GET /deliveries/1.json
  def show
  end

  # GET /deliveries/new
  def new
    @delivery = Delivery.new
  end

  # GET /deliveries/1/edit
  def edit
  end

  # POST /deliveries
  # POST /deliveries.json
  def create
    @delivery = Delivery.new(delivery_params)

    respond_to do |format|
      if @delivery.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @delivery.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deliveries/1
  # PATCH/PUT /deliveries/1.json
  def update
    respond_to do |format|
      if @delivery.update(delivery_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @delivery.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy
    @delivery.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to deliveries_url, notice: 'Delivery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    def check_role
      @user = current_user
      if (@user.has_role? :admin) || (@user.has_role? :logist)

      else
        redirect_to main_page_index_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_params
      params.require(:delivery).permit(:direction, :cost, :execution_document, :check_factory, :bank_service, :bank_percent)
    end
end
