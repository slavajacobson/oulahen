require 'test_helper'

class TeamPhotosControllerTest < ActionController::TestCase
  setup do
    @team_photo = team_photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_photo" do
    assert_difference('TeamPhoto.count') do
      post :create, team_photo: { description: @team_photo.description, image: @team_photo.image, order: @team_photo.order }
    end

    assert_redirected_to team_photo_path(assigns(:team_photo))
  end

  test "should show team_photo" do
    get :show, id: @team_photo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team_photo
    assert_response :success
  end

  test "should update team_photo" do
    patch :update, id: @team_photo, team_photo: { description: @team_photo.description, image: @team_photo.image, order: @team_photo.order }
    assert_redirected_to team_photo_path(assigns(:team_photo))
  end

  test "should destroy team_photo" do
    assert_difference('TeamPhoto.count', -1) do
      delete :destroy, id: @team_photo
    end

    assert_redirected_to team_photos_path
  end
end
