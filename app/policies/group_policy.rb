class GroupPolicy < ApplicationPolicy
  def create?
    record.owner_id == user.id
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
