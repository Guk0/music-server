class UserGroupPolicy < ApplicationPolicy
  def create?
    record.owner_id == user.id
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
