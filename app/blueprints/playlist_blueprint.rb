class PlaylistBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :list_type, :owner_type, :owner_id

  view :detail do
    association :tracks, blueprint: TrackBlueprint, view: :playlist
  end
end
