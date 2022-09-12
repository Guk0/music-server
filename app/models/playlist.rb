class Playlist < ApplicationRecord
  PERMITTED_OWNER = {user: User, group: Group}


  belongs_to :owner, polymorphic: true

  has_many :playlist_tracks, dependent: :destroy

  enum list_type: { default: 0, my_album: 1 }


  def check_user user
    if owner_type == "Group"
      group = Group.find(owner_id)
      group.users.include?(user)
    else
      owner == user
    end
  end
end
