class PlaylistTrackBlueprint < Blueprinter::Base
  identifier :id

  fields :user_id
  association :track, blueprint: TrackBlueprint
end
