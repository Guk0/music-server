class Group < ApplicationRecord
  has_many :playlist, as: :owner
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
end
