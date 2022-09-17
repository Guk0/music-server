class Playlist < ApplicationRecord
  PERMITTED_OWNER = {user: User, group: Group}


  belongs_to :owner, polymorphic: true

  has_many :playlist_tracks, dependent: :destroy
  has_many :tracks, through: :playlist_tracks

  enum list_type: { default: 0, my_album: 1 }


  def check_user user
    # 그룹인 경우와 그렇지 않은 경우 권한 체크
    if owner_type == "Group"
      group = Group.find(owner_id)
      group.users.find_by(id: user.id)
    else
      owner == user
    end
  end
end
