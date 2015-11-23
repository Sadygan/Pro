class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  # before_action :check_role

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @client.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @client.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    def check_role
      @user = current_user
      if (@user.has_role? :admin) || (@user.has_role? :company_moderator)

      else
        redirect_to main_page_index_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :status_position, :telephone, :email, :company_id)
    end
end
