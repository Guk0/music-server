class GroupPolicy < ApplicationPolicy
  def update?
    record.owner_id == user.id
  end

  def destroy?
    record.owner_id == user.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
