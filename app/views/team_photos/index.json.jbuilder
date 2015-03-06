json.array!(@team_photos) do |team_photo|
  json.extract! team_photo, :image, :order, :description
  json.url team_photo_url(team_photo, format: :json)
end
