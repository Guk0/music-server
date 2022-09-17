# Create elastic search index. Returns nil and doesn't create index if indexes already exists.
Track.__elasticsearch__.create_index!

seed_class = GenerateSeed.new()
# seed_class.generate_artists
# seed_class.generate_albums
# seed_class.generate_tracks
seed_class.generate_artists_albums_tracks