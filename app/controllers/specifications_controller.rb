class SpecificationsController < ApplicationController
  # before_action :check_role
  before_action :set_specification, only: [:show, :edit, :update, :destroy]
  
  def index
    @specifications = Specification.all
    if user_signed_in?
      
    else
      redirect_to new_user_session_path
    end
  end
 
  def show

    if user_signed_in?
      redirect_to projects_path
    else
      redirect_to new_user_session_path and return
    end  
  end
 
  def new
    @specification = Specification.new
    @project = Project.find(params[:project_id])
  end
 
  def create
    @projects = Project.all
    @specifications = Specification.all
    
    @project = Project.find(params[:project_id])
    @specification = @project.specifications.new(specification_params)
 
    respond_to do |format|
      if @specification.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @specification.errors.full_messages, 
                            status: :unprocessable_entity }
      end
      
    end
  end
 
  def edit
    @project = Project.find(params[:project_id])
  end
 
  def update
    @project = Project.find(params[:project_id])
     respond_to do |format|
      if @specification.update(specification_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @specification.errors.full_messages,
                                   status: :unprocessable_entity }
        format.js
      end
     
    end
  end
  
  def destroy
 
    @specification.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

private
  
  def set_specification
    @specification = Specification.find(params[:id])
  end
  
  def check_role
    @user = current_user
    if (@user.has_role? :admin) || (@user.has_role? :company_moderator) || (@user.has_role? :manager)

    else
      redirect_to main_page_index_path
    end
  end

  def specification_params
    params.require(:specification).permit(:name, :print_sum, :light, :project_id, :currency_id, :note)
  end
 
end