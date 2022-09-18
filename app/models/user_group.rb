class UserGroup < ApplicationRecord
  validates :user, uniqueness: { scope: :group }

  belongs_to :user
  belongs_to :group
end
