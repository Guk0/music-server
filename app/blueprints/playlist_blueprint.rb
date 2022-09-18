class PlaylistBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :list_type
	association :owner, blueprint: ->(owner) { owner.blueprint }

  view :detail do
    association :tracks, blueprint: TrackBlueprint, view: :playlist
  end
end
