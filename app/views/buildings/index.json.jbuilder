json.array!(@buildings) do |building|
  json.extract! building, :id, :address, :zip, :rating_sum, :rating_count
  json.url building_url(building, format: :json)
end
