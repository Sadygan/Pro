class ProjectsController < ApplicationController
  respond_to :html, :json
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    
    @user = current_user
    @projects = @user.projects.all 
    @last_status = Status.new.array_status.last

    if user_signed_in?
      
    else
      redirect_to new_user_session_path
    end

  end
 
  def show
    if user_signed_in?
         
    else
      redirect_to new_user_session_path and return
    end

    authorize! :show, @project

    @totals = @project.specifications
    @specifications = @project.specifications.all
    @user = current_user
    @table_specifications = Project.find_table_specifications(@specifications)
    # @tables = Table.all

    respond_to do |format|
      format.html
      format.pdf do 
        pdf = TableSpecificationPdf.new(@project, @specifications, @table_specifications, @user)
        send_data pdf.render, filename: "project_#{@project.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
 
  def new
    @project = Project.new
  end
 
  def create
    
    @user = current_user
    @project = @user.projects.create(project_params)
    
    respond_to do |format|
      if @project.save
        status_name = Status.new.array_status[0]
        @project.statuses.create(name: status_name)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @project.errors.full_messages, 
                            status: :unprocessable_entity }
      end
      
    end
  end
 
  def edit
  end
 
  def update
     respond_to do |format|
      if @project.update(project_params)
        format.json { head :no_content }
        format.js
      else
         format.json { respond_with_bip(@project) }
      end
     
    end
  end
 
  def destroy
 
    @project.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

private
  
  def set_project
    @project = Project.find(params[:id])
  end

  def status_params
    params.require(:status).permit(:name, :description, :project_id)
  end
  
  def project_params
    params.require(:project).permit(
      :object_name, 
      :type_furniture, 
      # :date_request, 
      :deadline, 
      :planned_budget, 
      :date_delivery_client, 
      :amount_contract, 
      :client_prepayment,
      :factory_prepayment,
      :client_surcharge,
      :factory_surcharge,
      :status_transaction,
      :delivery_status,
      :user_id,
      :city_id,
      :style_id,
      :client_id,
      :print_sum
      )
  end
 
end