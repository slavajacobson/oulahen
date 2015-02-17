json.array!(@neighbourhoods) do |neighbourhood|
  json.extract! neighbourhood, :schools, :condo_apts, :detached, :condo_towns, :condo_other
  json.url neighbourhood_url(neighbourhood, format: :json)
end
