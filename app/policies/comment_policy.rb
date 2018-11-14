class CommentPolicy < ApplicationPolicy
  def update?
    user.id == comment.user_id
  end

  def edit?
    user.id == comment.user_id
  end

  def destroy?
    user.id == comment.user_id
  end

  class Scope
    def resolve
      scope
    end
  end

  private

  def comment
    record
  end
end
