# app/policies/comment_policy.rb

class CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user.admin? || record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
