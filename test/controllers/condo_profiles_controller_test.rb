require 'test_helper'

class CondoProfilesControllerTest < ActionController::TestCase
  setup do
    @condo_profile = condo_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:condo_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create condo_profile" do
    assert_difference('CondoProfile.count') do
      post :create, condo_profile: { address: @condo_profile.address, built_on: @condo_profile.built_on, corporation: @condo_profile.corporation, distance_from_transit: @condo_profile.distance_from_transit, floors: @condo_profile.floors, management: @condo_profile.management, school_zone: @condo_profile.school_zone, total_owned: @condo_profile.total_owned, total_rented: @condo_profile.total_rented, units: @condo_profile.units }
    end

    assert_redirected_to condo_profile_path(assigns(:condo_profile))
  end

  test "should show condo_profile" do
    get :show, id: @condo_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @condo_profile
    assert_response :success
  end

  test "should update condo_profile" do
    patch :update, id: @condo_profile, condo_profile: { address: @condo_profile.address, built_on: @condo_profile.built_on, corporation: @condo_profile.corporation, distance_from_transit: @condo_profile.distance_from_transit, floors: @condo_profile.floors, management: @condo_profile.management, school_zone: @condo_profile.school_zone, total_owned: @condo_profile.total_owned, total_rented: @condo_profile.total_rented, units: @condo_profile.units }
    assert_redirected_to condo_profile_path(assigns(:condo_profile))
  end

  test "should destroy condo_profile" do
    assert_difference('CondoProfile.count', -1) do
      delete :destroy, id: @condo_profile
    end

    assert_redirected_to condo_profiles_path
  end
end
