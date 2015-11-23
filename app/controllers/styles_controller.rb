class StylesController < ApplicationController
  # before_action :check_role
  before_action :set_style, only: [:show, :edit, :update, :destroy]

  # GET /styles
  # GET /styles.json
  def index
    @styles = Style.all
  end

  # GET /styles/1
  # GET /styles/1.json
  def show
  end

  # GET /styles/new
  def new
    @style = Style.new
  end

  # GET /styles/1/edit
  def edit
  end

  # POST /styles
  # POST /styles.json
  def create
    @style = Style.new(style_params)

    respond_to do |format|
      if @style.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @style.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /styles/1
  # PATCH/PUT /styles/1.json
  def update
    respond_to do |format|
      if @style.update(style_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @style.errors.full_messages,
                                   status: :unprocessable_entity }
      end
    end
  end

  # DELETE /styles/1
  # DELETE /styles/1.json
  def destroy
    @style.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to styles_url, notice: 'Style was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_style
      @style = Style.find(params[:id])
    end

    def check_role
      @user = current_user
      if (@user.has_role? :admin) || (@user.has_role? :company_moderator)

      else
        redirect_to main_page_index_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def style_params
      params.require(:style).permit(:name)
    end
end
