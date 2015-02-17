require 'test_helper'

class AmenitiesControllerTest < ActionController::TestCase
  setup do
    @amenity = amenities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:amenities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create amenity" do
    assert_difference('Amenity.count') do
      post :create, amenity: { condo_profile_id: @amenity.condo_profile_id }
    end

    assert_redirected_to amenity_path(assigns(:amenity))
  end

  test "should show amenity" do
    get :show, id: @amenity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @amenity
    assert_response :success
  end

  test "should update amenity" do
    patch :update, id: @amenity, amenity: { condo_profile_id: @amenity.condo_profile_id }
    assert_redirected_to amenity_path(assigns(:amenity))
  end

  test "should destroy amenity" do
    assert_difference('Amenity.count', -1) do
      delete :destroy, id: @amenity
    end

    assert_redirected_to amenities_path
  end
end
