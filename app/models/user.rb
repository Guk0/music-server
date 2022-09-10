class User < ApplicationRecord
  has_many :playlists, as: :owner
  has_many :user_groups
  has_many :groups, through: :user_groups
end
