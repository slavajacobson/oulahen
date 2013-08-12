class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  layout 'admin', only: [:new, :index, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :index, :edit, :update, :destroy, :disable_feature] 
  
  def disable_feature
    @listing = Listing.find(params[:listing_id])
    @listing.featured_listing = false
    @success = @listing.save


  end


  def transactions
    if params[:id] == 'homes' || params[:id].blank?
      @transactions = Listing.where(sold:true, category_id: 1, active: true).order("created_at DESC").page(params[:page]).per(20)
    elsif params[:id] == 'condos'
      @transactions = Listing.where(sold:true, category_id: 2, active: true).order("created_at DESC").page(params[:page]).per(20)
    elsif params[:id] == 'commercial'
      @transactions = Listing.where(sold:true, category_id: 3, active: true).order("created_at DESC").page(params[:page]).per(20)
    end
  end

  def residential
    @listings = Listing.where(active:true,category_id:[1,2], sold:false).order("created_at DESC").page(params[:page]).per(6)
    #debugger
    @header = "Residential Listings"
    
    render 'site_listings'
  end

  def commercial
    @header = "Commercial Listings"
    @listings = Listing.where(active:true,category_id:3, sold:false).order("created_at DESC").page(params[:page]).per(6)
    render 'site_listings'
  end

  # GET /listings
  # GET /listings.json
  def index
    Listing.destroy_all(draft:true, draft_by:current_user.id)
    @listings = Listing.all.order("created_at DESC").page(params[:page]).per(15)
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    #debugger
    @photos = @listing.photos
    @main_photo = Photo.where(listing_id: @listing.id, main_photo: true).first
    if @main_photo 
      @main_photo = @main_photo.image_url
    end
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
    #debugger
    @photos = @listing.photos
    @listing.build_floor_plan unless @listing.floor_plan.present?
    @listing.build_feature_sheet unless @listing.feature_sheet.present?
  end

  # POST /listings
  # POST /listings.json
  def create
    debugger
    #TODO: DELETE ALL
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
    #debugger
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


    if params[:delete_floor_plan]
      @listing.floor_plan.remove_file = true
      @listing.floor_plan._destroy
      @listing.floor_plan.destroy!
      @listing.floor_plan.save
    end

    if params[:delete_feature_sheet]
      @listing.feature_sheet.remove_file = true
      @listing.feature_sheet._destroy
      @listing.feature_sheet.destroy!
      @listing.feature_sheet.save
    end
    


    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: notice }
        format.json { head :no_content }
      else
        #debugger
        format.html { 
          @photos = @listing.photos
          @listing.build_floor_plan unless @listing.floor_plan.present?
          @listing.build_feature_sheet unless @listing.feature_sheet.present?
   

        }
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
      @listing = Listing.find_by_slug!(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit({photos_attributes: [:id,:image]}, {feature_sheet_attributes: [:id,:file]}, {floor_plan_attributes: [:id,:file]}, :active, :address, :street_number, :show_street_number, :unit_number, :show_unit_number, 
                                      :postal_code, :neighbourhood, :lot_frontage, :lot_depth, :sqft, :bedrooms, :bathrooms, :price, :sold_price, 
                                      :show_sold_price, :sold, :sold_status, :maintenance_fee, :virtual_tour_url, :map_url, :realtor_url, :facebook_url, 
                                      :description, :inclusions, :exclusions, :category_id, :featured_listing, :city_province, :transaction_label)
    end
end
