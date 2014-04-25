json.array!(@albums) do |album|
  json.extract! album, :id, :kind, :name, :band_id
  json.url album_url(album, format: :json)
end
