# frozen_string_literal: true

# froze_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(id)
    RepositoryService.call(id)
  end
end
