class PhotosController < ApplicationController
	def index

	end

	def new
    @photo = Photo.new(:listing => params[:listing_id])
  end

  def create
    @photo = Photo.create(photo_params)
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Successfully updated photo."

    else
      render :action => 'edit'
    end
  end

  def destroy

    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = "Successfully destroyed photo."

  end

  def delete_multiple
    Photo.destroy_all(id: params.require(:photo_ids))
    #debugger
    @photos = Photo.find_all_by_listing_id(photo_params[:listing_id]) #Listing.find(photo_params[:listing_id]).photos
    
  end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :id, :listing_id)
    end

end
