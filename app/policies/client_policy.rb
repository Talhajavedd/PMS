class ClientPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.manager?
  end

  def create?
    user.manager?
  end

  def update?
    user.manager?
  end

  def edit?
    user.manager?
  end

  def destroy?
    user.manager?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
