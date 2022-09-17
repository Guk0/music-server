class GenerateSeed
  attr_reader :albums

  TRACKS = [
    {
      artist: "아이유", albums: [
        { title: "Real", tracks: 
          [
            { title: "좋은날" },
            { title: "미리 메리 크리스마스 (Feat. 천둥 Of MBLAQ)" },
            { title: "첫 이별 그날 밤" },
            { title: "혼자 있는 방" },
          ]
        },
        { title: "Growing Up", tracks: 
          [
            { title: "바라보기" },
            { title: "Boo" },
            { title: "가여워" },
            { title: "A Dreamer" },
            { title: "미아" },
            { title: "미아(Acoustic Ver." },
            { title: "있잖아" },
          ]
        },
      ]
    },
    {
      artist: "BLACKPINK", albums: [
        { title: "SQUARE ONE", tracks:
          [
            { title: "휘파람" },
            { title: "붐바야" },
          ]
        },
        { title: "SQUARE TWO", tracks:
          [
            { title: "불장난" },
            { title: "STAY" },
          ]
        }
      ]
    }
  ]

  def generate_artists_albums_tracks
    TRACKS.each do |track_hash|
      artist = Artist.create!(name: track_hash[:artist])
      track_hash[:albums].each do |album|
        new_album = Album.create!(title: album[:title], artist: artist)
        album[:tracks].each do |track|
          track = Track.create(
            title: track[:title], 
            artist: artist, 
            album: new_album,
            artist_name: artist.name,
            album_name: new_album.title,
          )
        end        
      end
    end
  end


  # def initialize()
  #   @albums = []
  # end

  # def generate_artists
  #   p "generate artists"
  #   artists = []
  #   50_000.times do |i|
  #     artists << Artist.new(
  #       name: Faker::Lorem.sentence(word_count: 4)
  #     )
  #   end
  #   Artist.import artists
  # end

  # def generate_albums
  #   p "generate albums"
  #   artist_size = Artist.count
  #   200_000.times do |i|
  #     albums << Album.new(
  #       artist_id: rand(1..artist_size),
  #       title: Faker::Lorem.sentence(word_count: 4)
  #     )
  #   end
  #   Album.import albums
  # end

  # def generate_tracks
  #   p "generate tracks"
  #   tracks = []
  #   1_000_000.times do |i|
  #     album = albums.sample
  #     tracks << Track.new(
  #       artist_id: album.artist_id,
  #       album_id: album.id,
  #       artist_name: album.artist.name,
  #       album_name: album.title,
  #       title: Faker::Lorem.sentence(word_count: 4) # Lorem의 list 크기는 128로 4개의 단어라면 2,000,000만 가지의 경우의 수가 나옴.
  #     )
  #   end

  #   Track.import tracks
  # end
end