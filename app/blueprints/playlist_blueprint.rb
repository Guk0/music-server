class PlaylistBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :list_type

  view :with_owner do
    association :owner, blueprint: ->(playlist) { playlist.owner.blueprint }
  end

  view :detail do
    include_view :with_owner
    association :tracks, blueprint: TrackBlueprint, view: :playlist
  end
end
