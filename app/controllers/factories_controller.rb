class FactoriesController < ApplicationController
 
  before_action :set_factory, only: [:show, :edit, :update, :destroy]
  
  def index
    @factorys = Factory.all
    
    if user_signed_in?
      # redirect_to factories_path 
    else
      redirect_to new_user_session_path
    end

  end
 
  def show
    
    if user_signed_in?
      redirect_to factories_path 
    else
      redirect_to new_user_session_path
    end
    authorize! :read, @factory
  end
  
  def brand
    @factories = Factory.order([:id]).where("brand like ?", "%#{params[:id]}%")
    render json: @factories.map{|x| {id: x.id, brand: x.brand, discount: x.discounts, additional_discount: x.additional_discount, light_factor: x.light_factor}}
  end

  def new
    @factory = Factory.new
    @factory.discounts.build #build discounts attributes, nothing new here
  end
 
  def create
    @factory = Factory.create(factory_params)
    
    respond_to do |format|
      if @factory.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @factory.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end
 
  def edit
    authorize! :update, @factory
  end
 
  def update
     respond_to do |format|
      if @factory.update(factory_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @factory.errors.full_messages,
                                   status: :unprocessable_entity }
      end
     
    end
  end
  
  def destroy
 
    @factory.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
 
private
  
  def set_factory
    @factory = Factory.find(params[:id])
  end
  
  def factory_params
    params.require(:factory).permit(:brand, :web, :autorification, :style, :line_product, :catalog, :price, :additional_discount, :delivery_terms, :note,:light_factory_id, discounts_attributes:[:percent, :_destroy, :id])
  end
 
end