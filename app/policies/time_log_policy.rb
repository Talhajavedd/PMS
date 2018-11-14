class TimeLogPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    user.id == time_log.user_id
  end

  def update?
    user.id == time_log.user_id
  end

  def destroy?
    user.id == time_log.user_id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def time_log
    record
  end
end
