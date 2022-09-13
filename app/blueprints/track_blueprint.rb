class TrackBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :likes_count, :created_at, :updated_at
  association :artist, blueprint: ArtistBlueprint
  association :album, blueprint: AlbumBlueprint
end
