# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  # BEGIN
  def create?
    user
  end

  def update?
    user&.admin || record.author == user
  end

  def destroy?
    user&.admin
  end
  # END
end
