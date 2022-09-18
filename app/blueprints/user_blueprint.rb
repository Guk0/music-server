class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :created_at, :updated_at

  view :with_playlists do
    association :playlists, blueprint: PlaylistBlueprint do |user|
      user.playlists.my_album
    end  
  end
end
