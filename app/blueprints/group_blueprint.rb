class GroupBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :created_at, :updated_at
  association :owner, blueprint: UserBlueprint
  
  view :with_playlists do
    association :playlists, blueprint: PlaylistBlueprint do |group|
      group.playlists.my_album
    end  
  end
end
