class User < ApplicationRecord
  has_many :playlists, as: :owner
  has_many :user_groups
  has_many :groups, through: :user_groups
  
  has_many :owned_groups, class_name: "Group", foreign_key: "owner_id"

  after_create :create_default_playlist

  def create_default_playlist
    playlists.default.create(title: "재생목록")
  end
end
