# frozen_string_literal: true

module UserConcern
  def user_limit(limit)
    limit.present? ? User.limit(limit) : User.all
  end
end