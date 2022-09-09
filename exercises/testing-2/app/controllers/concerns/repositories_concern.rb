# frozen_string_literal: true

module RepositoriesConcern
  def url_parser(link)
    uri = URI.parse(link)
    _empty, owner, repo = uri.path.split('/')
    { link: link, owner: owner, repo: repo }
  end
end
