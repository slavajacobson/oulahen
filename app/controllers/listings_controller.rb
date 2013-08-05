class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  before_filter :authenticate_user!
  
  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @photos = @listing.photos
  end

  # GET /listings/new
  def new
    Listing.destroy_all(draft:true, draft_by:current_user.id)

    @listing = Listing.create(draft_by: current_user.id)

    @listing.build_floor_plan
    @listing.build_feature_sheet

    @photos = Photo.new


    #@listing.photos.build
  end

  # GET /listings/1/edit
  def edit

    @photos = @listing.photos
    @listing.build_floor_plan
    @listing.build_feature_sheet
  end

  # POST /listings
  # POST /listings.json
  def create
    #debugger

    @listing = Listing.new(listing_params)



    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @listing }
      else
        format.html { render action: 'new' }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update

    unless @listing.photos.blank? || @listing.photos.find_by_main_photo(true)
      @listing.photos[0].main_photo = true
      @listing.photos[0].save
    end

    if @listing.draft
      @listing.draft = false
      notice = 'Listing was successfully created.'
    else
      notice = 'Listing was successfully updated.'
    end
    
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to listings_path, notice: notice }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit({photos_attributes: [:id,:image]}, {feature_sheet_attributes: [:id,:file]}, {floor_plan_attributes: [:id,:file]}, :active, :address, :street_number, :show_street_number, :unit_number, :show_unit_number, 
                                      :postal_code, :neighbourhood, :lot_frontage, :lot_depth, :sqft, :bedrooms, :bathrooms, :price, :sold_price, 
                                      :show_sold_price, :sold, :sold_status, :maintenance_fee, :virtual_tour_url, :map_url, :realtor_url, :facebook_url, 
                                      :description, :inclusions, :exclusions, :category_id, :featured_listing)
    end
end
