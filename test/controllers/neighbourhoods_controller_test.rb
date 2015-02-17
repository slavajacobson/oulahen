require 'test_helper'

class NeighbourhoodsControllerTest < ActionController::TestCase
  setup do
    @neighbourhood = neighbourhoods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:neighbourhoods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create neighbourhood" do
    assert_difference('Neighbourhood.count') do
      post :create, neighbourhood: { condo_apts: @neighbourhood.condo_apts, condo_other: @neighbourhood.condo_other, condo_towns: @neighbourhood.condo_towns, detached: @neighbourhood.detached, schools: @neighbourhood.schools }
    end

    assert_redirected_to neighbourhood_path(assigns(:neighbourhood))
  end

  test "should show neighbourhood" do
    get :show, id: @neighbourhood
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @neighbourhood
    assert_response :success
  end

  test "should update neighbourhood" do
    patch :update, id: @neighbourhood, neighbourhood: { condo_apts: @neighbourhood.condo_apts, condo_other: @neighbourhood.condo_other, condo_towns: @neighbourhood.condo_towns, detached: @neighbourhood.detached, schools: @neighbourhood.schools }
    assert_redirected_to neighbourhood_path(assigns(:neighbourhood))
  end

  test "should destroy neighbourhood" do
    assert_difference('Neighbourhood.count', -1) do
      delete :destroy, id: @neighbourhood
    end

    assert_redirected_to neighbourhoods_path
  end
end
