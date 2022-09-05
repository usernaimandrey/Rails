# frozen_string_literal: true

module UserConcern
  def user_limit(request)
    url = URI.parse(request)
    params_query = CGI.parse(url.query) if url.query.present?
    params_query.present? ? User.limit(params_query['limit'].first) : User.all
  end
end