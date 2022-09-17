class User < ApplicationRecord
  has_many :playlists, as: :owner
  has_many :user_groups
  has_many :groups, through: :user_groups

  after_create :create_default_playlist

  def create_default_playlist
    playlists.default.create(title: "재생목록")
  end
end
