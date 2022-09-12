class GenerateSeed
  attr_reader :albums
  # track : 100만개
  # user : 3만명
  # artist : 50만명
  # album : 10만개

  def initialize()
    @albums = []
  end

  def generate_artists
    p "generate artists"
    artists = []
    50_000.times do |i|
      artists << Artist.new(
        name: Faker::Lorem.sentence(word_count: 4)
      )
    end
    Artist.import artists
  end

  def generate_albums
    p "generate albums"
    artist_size = Artist.count
    200_000.times do |i|
      albums << Album.new(
        artist_id: rand(1..artist_size),
        title: Faker::Lorem.sentence(word_count: 4)
      )
    end
    Album.import albums
  end

  def generate_tracks
    p "generate tracks"
    tracks = []
    1_000_000.times do |i|
      album = albums.sample
      tracks << Track.new(
        artist_id: album.artist_id,
        album_id: album.id,
        artist_name: album.artist.name,
        album_name: album.title,
        title: Faker::Lorem.sentence(word_count: 4) # Lorem의 list 크기는 128로 4개의 단어라면 2,000,000만 가지의 경우의 수가 나옴.
      )
    end

    Track.import tracks
  end
end