# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthConcern
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_auth_or_not_author if Rails.env != 'test'

  private

  def user_not_auth_or_not_author(exception)
    user = exception.policy.user
    if user.nil?
      flash[:alert] = t('.not_auth')
      redirect_to new_session_path
    else
      flash[:aler] = t('.not_author')
      redirect_to posts_path
    end
  end
end
