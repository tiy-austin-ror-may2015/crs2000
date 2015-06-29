json.array!(@rooms) do |room|
  json.extract! room, :id, :name, :max_occupancy, :room_number, :imgurl, :location
  json.url room_url(room, format: :json)
end
