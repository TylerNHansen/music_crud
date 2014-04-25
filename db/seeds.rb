# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

bands = []

20.times do
  bands << Band.create(name: Faker::Company.catch_phrase)
end

albums = []

bands.each do |band|
  5.times do
    albums << Album.create(band_id: band.id, name: Faker::Company.bs, kind: 'live')
  end

end

tracks = []

albums.each do |album|
  12.times do
    tracks << Track.create(
    album_id: album.id,
    lyrics: Faker::Lorem.paragraphs.join("\n"),
    title: Faker::Lorem.word,
    kind: 'regular'
    )
  end
end