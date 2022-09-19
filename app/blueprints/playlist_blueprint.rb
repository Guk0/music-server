class PlaylistBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :list_type

  view :with_owner do
    association :owner, blueprint: -> (owner) { owner.blueprint }
  end
end
