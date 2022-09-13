# frozen_string_literal: true

# froze_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    GitHubService.call(args.first)
  end
end
