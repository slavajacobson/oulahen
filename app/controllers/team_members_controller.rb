class TeamMembersController < ApplicationController
  before_action :set_team_member, only: [:show, :edit, :update, :destroy]
  layout 'admin', only: [:new, :index, :edit, :update, :destroy, :index]
  before_filter :authenticate_user!, only: [:new, :index, :edit, :update, :destroy, :add_custom_field] 
  #layout false
  # GET /team_members
  # GET /team_members.json
  def index
    @team_members = TeamMember.all
  end

  def about_us
    @team_members = TeamMember.where(draft: false)
  end

  # GET /team_members/1
  # GET /team_members/1.json
  def show
  end

  # GET /team_members/new
  def new
    TeamMember.destroy_all(draft:true, draft_by:current_user.id)

  
    @photos = Photo.new


    @team_member = TeamMember.create(draft_by: current_user.id)

    @team_member.custom_fields.build
  end

  # GET /team_members/1/edit
  def edit
    @photos = @team_member.photos.order("order_priority ASC")
  end

  # POST /team_members
  # POST /team_members.json
  def create
   # debugger
    @team_member = TeamMember.new(team_member_params)


    respond_to do |format|
      if @team_member.save
        format.html { redirect_to @team_member, notice: 'Team member was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team_member }
      else
        format.html { render action: 'new' }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_members/1
  # PATCH/PUT /team_members/1.json
  def update
  #debugger

    if @team_member.draft
      @team_member.draft = false
      notice = 'Member was successfully created.'
    else
      notice = 'Member was successfully updated.'
    end


    respond_to do |format|
      if @team_member.update(team_member_params)
        format.html { redirect_to @team_member, notice: 'Team member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_members/1
  # DELETE /team_members/1.json
  def destroy
    @team_member.destroy
    respond_to do |format|
      format.html { redirect_to team_members_url }
      format.json { head :no_content }
    end
  end

  def add_custom_field
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_member
      @team_member = TeamMember.find_by_slug!(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_member_params
      params.require(:team_member).permit(:name, :title, :bio, :mini_bio, :custom_fields_attributes => [:field_name, :value, :id, :_destroy])
    end
end
