json.array!(@listings) do |listing|
  json.extract! listing, :address, :street_number, :hide_street_number, :unit_number, :hide_unit_number, :postal_code, :neighbourhood, :lot_frontage, :lot_depth, :sqft, :bedrooms, :bathrooms, :price, :sold_price, :hide_sold_price, :sold, :sold_status, :maintenance_fee, :virtual_tour_url, :map_url, :realtor_url, :facebook_url, :description, :inclusions, :exclusions
  json.url listing_url(listing, format: :json)
end
