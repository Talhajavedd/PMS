class ProjectPolicy < ApplicationPolicy
  def show?
    project.users.exists?(id: user.id) || user.manager?
  end

  def new
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

  private

  def project
    record
  end
end
