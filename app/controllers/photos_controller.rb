class PhotosController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :index, :edit, :update, :destroy, :manipulate] 



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

  def manipulate

   

    if params[:delete_photos]
      
      @photos_to_delete = params.require(:photo_ids)

      Photo.destroy_all(id: @photos_to_delete)

      


      #if the deleted photo was the main photo, pick a new main photo
      # unless Photo.where(listing_id: photo_params[:listing_id], main_photo: true).first
      #   @photos = Photo.find_all_by_listing_id(photo_params[:listing_id])
        
      #   if @photos[0]
      #     @photos[0].main_photo = true
      #     @photos[0].save
      #   end
      # end
      
    elsif params[:set_main_photo]
      #debugger
      @current_main_photo = Photo.where(main_photo: true, listing_id: photo_params[:listing_id]).first

      unless @current_main_photo.blank?
        #debugger
        @current_main_photo.main_photo = false
        @current_main_photo.save
      end


      @photo = Photo.find(params[:photo_ids][0])
      @photo.main_photo = true
      @photo.save

    elsif params[:save_photo_order]
      params[:order].each do |photo|
        photo = JSON.parse photo

        Photo.find(photo['photo_id']).update_attributes(order_priority: photo['order'])
        #debugger

      end

    end


    @photos = Photo.where(listing_id: photo_params[:listing_id]).order("order_priority ASC")

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
