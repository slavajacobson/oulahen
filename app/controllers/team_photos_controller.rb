class TeamPhotosController < ApplicationController
  before_action :set_team_photo, only: [:show, :edit, :update, :destroy]

  layout 'admin', only: [:new, :index, :edit, :update, :destroy, :index]
  before_filter :authenticate_user!, only: [:new, :index, :edit, :update, :destroy, :update_order] 
  # GET /team_photos
  # GET /team_photos.json
  def index
    @team_photos = TeamPhoto.all.order(order: :asc)
  end

  # GET /team_photos/1
  # GET /team_photos/1.json
  def show
  end

  # GET /team_photos/new
  def new
    @team_photo = TeamPhoto.new
  end

  # GET /team_photos/1/edit
  def edit
  end
  def update_order
      
      
      
      respond_to do |format|
         format.js {
            #debugger
            new_order = params[:team_photo]
            
            new_order.each_with_index do |order, i|
                #debugger
                teamphoto = TeamPhoto.find(order)
                teamphoto.order = i
                teamphoto.save
            end
             
         }

      end
      
      
  end
  # POST /team_photos
  # POST /team_photos.json
  def create
    @team_photo = TeamPhoto.new(team_photo_params)

    respond_to do |format|
      if @team_photo.save
        format.html { redirect_to team_photos_path, notice: 'Team photo was successfully created.' }
        format.json { render action: team_photos_path, status: :created, location: @team_photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @team_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_photos/1
  # PATCH/PUT /team_photos/1.json
  def update
    respond_to do |format|
      if @team_photo.update(team_photo_params)
        format.html { redirect_to team_photos_path, notice: 'Team photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_photos/1
  # DELETE /team_photos/1.json
  def destroy
    @team_photo.destroy
    respond_to do |format|
      format.html { redirect_to team_photos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_photo
      @team_photo = TeamPhoto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_photo_params
      params.require(:team_photo).permit(:image, :order, :description)
    end
end
