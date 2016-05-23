class GroupLinesController < ApplicationController
  # before_action :set_city, only: [:show, :edit, :update, :destroy]
  before_action :set_specification, only: [:create]
  
  def new
    @group_line = GroupLine.new
  end

  def create
    # p params[:specification_id]
    # @specification = Specification.find(params[:specification_id])
    @group_line = GroupLine.create(group_line_params)
    respond_to do |format|
      if @group_line.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @client.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  def destroy
  
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_specification
  end

  def set_group_line
    @group_line = GroupLine.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_line_params
    params.require(:group_line).permit(:name, :note, :specification_id)
  end

end
