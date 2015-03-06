json.array!(@maintenances) do |maintenance|
  json.extract! maintenance, :label, :icon
  json.url maintenance_url(maintenance, format: :json)
end
