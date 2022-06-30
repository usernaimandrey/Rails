# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def not_found
    raise ActionController::RoutingError, 'Not Found'
  rescue StandardError
    render404
  end

  def render404
    render file: Rails.root.join('public/404.html'), status: :not_found
  end
end
