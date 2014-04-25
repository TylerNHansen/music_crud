json.array!(@tracks) do |track|
  json.extract! track, :id, :lyrics, :kind, :album_id
  json.url track_url(track, format: :json)
end
