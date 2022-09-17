class TrackBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :likes_count, :created_at, :updated_at

  view :with_association do
    association :artist, blueprint: ArtistBlueprint
    association :album, blueprint: AlbumBlueprint
  end

  view :playlist do
    fields :album_name, :artist_name
  end
end
