class StatusesController < ApplicationController
  # before_action :check_role
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
  end

  # GET /statuses/new
  def new
    @project = Project.find(params[:project_id])
    last_status = @project.statuses.last.name

    if last_status != Status.new.array_status.last 
      @status = Status.new
    else
     respond_to do |format|
        format.html { redirect_to projects_path, notice: 'Status was not successfully create.' }
      end
    end
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @project = Project.find(params[:project_id])
   
    last_status = @project.statuses.last.name
    status_name = Status.new.change(last_status)
    @last_status = Status.new.array_status.last
    
    @status = @project.statuses.new(name: status_name)

    @status.update(status_params)

    respond_to do |format|
      if @status.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @status.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    respond_to do |format|
      if @status.update(status_params)
        # format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        # format.json { render :show, status: :ok, location: @status }
      else
        # format.html { render :edit }
        # format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end
    
    def check_role
      @user = current_user
      if (@user.has_role? :admin) || (@user.has_role? :company_moderator) || (@user.has_role? :manager)

      else
        redirect_to main_page_index_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:description)
    end
end
