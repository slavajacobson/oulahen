json.array!(@schools) do |school|
  json.extract! school, :name, :url, :neighbourhood_id
  json.url school_url(school, format: :json)
end
