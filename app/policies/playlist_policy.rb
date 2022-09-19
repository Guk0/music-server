class PlaylistPolicy < ApplicationPolicy
  def update?
    if record.owner_type == "Group"
      group = Group.find(record.owner_id)
      group.users.find_by(id: user.id)
    else
      record.owner == user
    end
  end

  def create?
    update?
  end

  def destroy?
    update?
  end

  def my_playlist?
    if record.class.name == "User"
      record.id == user.id
    else
      record.users.find_by(id: user.id).present?
    end
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
