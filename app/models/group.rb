class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }

  belongs_to :owner, class_name: "User"

  has_many :playlists, as: :owner
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups

  after_create :create_default_playlist

  def create_default_playlist
    playlists.default.create(title: "그룹 재생목록")
  end

  def check_user user
    owner_id == user.id
  end

  def blueprint
    GroupBlueprint
  end
end
