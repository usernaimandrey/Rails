# frozen_string_literal: true

class GitHubService
  class << self
    def create_repo(response, options)
      return if response.blank?

      attr = {
        owner_name: options[:owner],
        repo_name: options[:repo],
        link: options[:link],
        description: response[:description],
        default_branch: response[:default_branch],
        watchers_count: response[:watchers_count],
        language: response[:language],
        repo_created_at: response[:created_at],
        repo_updated_at: response[:updated_at]
      }
      repo = Repository.new(attr)
      repo.save
      repo
    end

    def call(client, options = {})
      client.repo(options)
    rescue StandardError
      {}
    end
  end
end
