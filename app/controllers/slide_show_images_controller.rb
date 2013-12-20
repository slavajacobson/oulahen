class SlideShowImagesController < ApplicationController
  before_action :set_slide_show_image, only: [:show, :edit, :update, :destroy]
  layout 'admin', only: [:new, :index, :edit, :update, :destroy, :show]
  before_filter :authenticate_user!, only: [:new, :index, :edit, :update, :destroy] 

  # GET /slide_show_images
  # GET /slide_show_images.json
  def index
    @slide_show_images = SlideShowImage.all.order(order: :asc)
    @listings = Listing.where(featured_listing: true, active: true).order(priority: :desc)
  end

  # GET /slide_show_images/1
  # GET /slide_show_images/1.json
  def show
  end

  # GET /slide_show_images/new
  def new
    @slide_show_image = SlideShowImage.new
  end

  # GET /slide_show_images/1/edit
  def edit
    @slide_show_image.video = "http://www.youtube.com/watch?v=#{@slide_show_image.video}"
  end

  # POST /slide_show_images
  # POST /slide_show_images.json
  def create
    @slide_show_image = SlideShowImage.new(slide_show_image_params)


    if @slide_show_image.is_video
      video_param = CGI.parse(URI.parse(@slide_show_image.video).query)
      @slide_show_image.video = video_param['v'][0]
    end

    respond_to do |format|
      if @slide_show_image.save
        format.html { redirect_to @slide_show_image, notice: 'Slide show image was successfully created.' }
        format.json { render action: 'show', status: :created, location: @slide_show_image }
      else
        format.html { render action: 'new' }
        format.json { render json: @slide_show_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_order
      
      
      
      respond_to do |format|
         format.js {
          
            new_order = params[:slideshow]
            
            new_order.each_with_index do |order, i|
                #debugger
                slideshow = SlideShowImage.find(order)
                slideshow.order = i
                slideshow.save
            end
             
         }

      end
      
      
  end
  # PATCH/PUT /slide_show_images/1
  # PATCH/PUT /slide_show_images/1.json
  def update
    if params[:slide_show_image][:is_video] == "1"

      video_param = CGI.parse(URI.parse(params[:slide_show_image][:video]).query)
                  
      params[:slide_show_image][:video] = video_param['v'][0]

    end


    respond_to do |format|

      if @slide_show_image.update(slide_show_image_params)
        format.html { redirect_to @slide_show_image, notice: 'Slide show image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @slide_show_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slide_show_images/1
  # DELETE /slide_show_images/1.json
  def destroy
    @slide_show_image.destroy
    respond_to do |format|
      format.html { redirect_to slide_show_images_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slide_show_image
      @slide_show_image = SlideShowImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slide_show_image_params
      params.require(:slide_show_image).permit(:image, :description_line1, :description_line2, :is_video, :video, :link_to, :active)
    end
end
