class CondoProfilesController < ApplicationController
  before_action :set_condo_profile, only: [:show, :edit, :update, :destroy]

  layout 'admin', only: [:new,:edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :index, :edit, :update, :destroy] 

  # GET /condo_profiles
  # GET /condo_profiles.json
  def index
    
  end

  def view_all

    @condo_profiles = CondoProfile.all.page(params[:page]).per(50)
  end
  # GET /condo_profiles/1
  # GET /condo_profiles/1.json
  def show
    @walk_score = get_walk_score if @condo_profile.lat.present?
    @transit_score = get_transit_score if @condo_profile.lat.present?
  end

  # GET /condo_profiles/new
  def new
    CondoProfile.destroy_all(draft:true, draft_by:current_user.id)

    @condo_profile = CondoProfile.create(draft_by: current_user.id)

    @condo_profile.build_floor_plan

    @photos = Photo.new
  end

  # GET /condo_profiles/1/edit
  def edit
    @photos = @condo_profile.photos.order("order_priority ASC")
    @condo_profile.build_floor_plan unless @condo_profile.floor_plan.present?

  end

  # POST /condo_profiles
  # POST /condo_profiles.json
  def create
    @condo_profile = CondoProfile.new(condo_profile_params)

    respond_to do |format|
      if @condo_profile.save
        format.html { redirect_to @condo_profile, notice: 'Condo profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @condo_profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @condo_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /condo_profiles/1
  # PATCH/PUT /condo_profiles/1.json
  def update
    if @condo_profile.draft
      @condo_profile.draft = false
      notice = 'Profile was successfully created.'
    else
      notice = 'Profile was successfully updated.'
    end


    unless @condo_profile.photos.blank? || @condo_profile.photos.find_by_main_photo(true)
      @condo_profile.photos[0].main_photo = true
      @condo_profile.photos[0].save
    end



    if params[:delete_floor_plan]
      @condo_profile.floor_plan.remove_file = true
      @condo_profile.floor_plan._destroy
      @condo_profile.floor_plan.destroy!
      @condo_profile.floor_plan.save
    end

    respond_to do |format|
      if @condo_profile.update(condo_profile_params)

        format.html { redirect_to @condo_profile, notice: 'Condo profile was successfully updated.' }
        format.json { head :no_content }
      else
        @photos = @condo_profile.photos
        @condo_profile.build_floor_plan unless @condo_profile.floor_plan.present?

        format.html { render action: 'edit' }
        format.json { render json: @condo_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /condo_profiles/1
  # DELETE /condo_profiles/1.json
  def destroy
    @condo_profile.destroy
    respond_to do |format|
      format.html { redirect_to condo_profiles_url }
      format.json { head :no_content }
    end
  end

  def search
    #debugger
    @result = CondoProfile.where("lower(address) like ?", "%#{params[:q]}%")
    #debugger
    render json: @result.map { |r| {address: r.address, url: condo_profile_path(r) }}
  end


  def get_coordinates
    respond_to do |format|
      format.js {
        @address = params[:address] + ' Toronto, Canada'
        
        google_api = JSON.load(open("http://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(@address)}"))

        @lat = google_api['results'][0]['geometry']['location']['lat']
        @lon = google_api['results'][0]['geometry']['location']['lng']


      }
    end

  end
  private
    def get_walk_score
      url = "http://api.walkscore.com/score?format=json&address=#{URI.encode(@condo_profile.address)}&lat=#{URI.encode(@condo_profile.lat)}&lon=#{URI.encode(@condo_profile.lon)}&wsapikey=b84b6a85455d2fe8fd04f93ce048518c"
      JSON.load(open(url))
    end

    def get_transit_score
      #http://transit.walkscore.com/transit/score/?lat=47.6101359&lon=-122.3420567&city=Seattle&state=WA&wsapikey=your_key
      #"http://api.walkscore.com/score?format=json&address=#{URI.encode(@condo_profile.address)}&lat=#{URI.encode(@condo_profile.lat)}&lon=#{URI.encode(@condo_profile.lon)}&wsapikey=b84b6a85455d2fe8fd04f93ce048518c"
      url = "http://transit.walkscore.com/transit/score/?lat=#{URI.encode(@condo_profile.lat)}&lon=#{URI.encode(@condo_profile.lon)}&city=toronto&country=CA&wsapikey=b84b6a85455d2fe8fd04f93ce048518c"
      JSON.load(open(url))

    end

    # Use callbacks to share common setup or constraints between actions.
    def set_condo_profile
      @condo_profile = CondoProfile.find_by_slug!(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def condo_profile_params
      params.require(:condo_profile).permit(:draft, :neighbourhood_id, :active, :priority, :lon, :lat, :address, :built_on, :floors, :units, :corporation, { :amenities => [] }, :management, :school_zone, :distance_from_transit, :total_rented, :total_owned, {floor_plan_attributes: [:id,:file]})
    end
end
