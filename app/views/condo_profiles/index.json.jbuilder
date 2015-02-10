json.array!(@condo_profiles) do |condo_profile|
  json.extract! condo_profile, :address, :built_on, :floors, :units, :corporation, :management, :school_zone, :distance_from_transit, :total_rented, :total_owned
  json.url condo_profile_url(condo_profile, format: :json)
end
