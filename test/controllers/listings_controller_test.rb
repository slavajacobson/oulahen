require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  setup do
    @listing = listings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:listings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create listing" do
    assert_difference('Listing.count') do
      post :create, listing: { address: @listing.address, bathrooms: @listing.bathrooms, bedrooms: @listing.bedrooms, description: @listing.description, exclusions: @listing.exclusions, facebook_url: @listing.facebook_url, hide_sold_price: @listing.hide_sold_price, hide_street_number: @listing.hide_street_number, hide_unit_number: @listing.hide_unit_number, inclusions: @listing.inclusions, lot_depth: @listing.lot_depth, lot_frontage: @listing.lot_frontage, maintenance_fee: @listing.maintenance_fee, map_url: @listing.map_url, neighbourhood: @listing.neighbourhood, postal_code: @listing.postal_code, price: @listing.price, realtor_url: @listing.realtor_url, sold: @listing.sold, sold_price: @listing.sold_price, sold_status: @listing.sold_status, sqft: @listing.sqft, street_number: @listing.street_number, unit_number: @listing.unit_number, virtual_tour_url: @listing.virtual_tour_url }
    end

    assert_redirected_to listing_path(assigns(:listing))
  end

  test "should show listing" do
    get :show, id: @listing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @listing
    assert_response :success
  end

  test "should update listing" do
    patch :update, id: @listing, listing: { address: @listing.address, bathrooms: @listing.bathrooms, bedrooms: @listing.bedrooms, description: @listing.description, exclusions: @listing.exclusions, facebook_url: @listing.facebook_url, hide_sold_price: @listing.hide_sold_price, hide_street_number: @listing.hide_street_number, hide_unit_number: @listing.hide_unit_number, inclusions: @listing.inclusions, lot_depth: @listing.lot_depth, lot_frontage: @listing.lot_frontage, maintenance_fee: @listing.maintenance_fee, map_url: @listing.map_url, neighbourhood: @listing.neighbourhood, postal_code: @listing.postal_code, price: @listing.price, realtor_url: @listing.realtor_url, sold: @listing.sold, sold_price: @listing.sold_price, sold_status: @listing.sold_status, sqft: @listing.sqft, street_number: @listing.street_number, unit_number: @listing.unit_number, virtual_tour_url: @listing.virtual_tour_url }
    assert_redirected_to listing_path(assigns(:listing))
  end

  test "should destroy listing" do
    assert_difference('Listing.count', -1) do
      delete :destroy, id: @listing
    end

    assert_redirected_to listings_path
  end
end
