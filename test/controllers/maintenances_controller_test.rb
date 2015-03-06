require 'test_helper'

class MaintenancesControllerTest < ActionController::TestCase
  setup do
    @maintenance = maintenances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maintenances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maintenance" do
    assert_difference('Maintenance.count') do
      post :create, maintenance: { icon: @maintenance.icon, label: @maintenance.label }
    end

    assert_redirected_to maintenance_path(assigns(:maintenance))
  end

  test "should show maintenance" do
    get :show, id: @maintenance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @maintenance
    assert_response :success
  end

  test "should update maintenance" do
    patch :update, id: @maintenance, maintenance: { icon: @maintenance.icon, label: @maintenance.label }
    assert_redirected_to maintenance_path(assigns(:maintenance))
  end

  test "should destroy maintenance" do
    assert_difference('Maintenance.count', -1) do
      delete :destroy, id: @maintenance
    end

    assert_redirected_to maintenances_path
  end
end
