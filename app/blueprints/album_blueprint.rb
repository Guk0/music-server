class AlbumBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :created_at, :updated_at

  view :detail do
    association :artist, blueprint: ArtistBlueprint
    association :tracks, blueprint: TrackBlueprint
  end
end
