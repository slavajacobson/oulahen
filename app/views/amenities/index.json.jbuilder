json.array!(@amenities) do |amenity|
  json.extract! amenity, :condo_profile_id
  json.url amenity_url(amenity, format: :json)
end
