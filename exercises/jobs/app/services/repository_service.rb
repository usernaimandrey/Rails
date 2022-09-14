# frozen_string_literal: true

class RepositoryService
  class << self
    def call(id)
      repository = Repository.find_by(id: id)
      repository.fetch!

      owner_and_repo = Octokit::Repository.from_url(repository.link)

      response = Octokit::Client.new.repo(owner_and_repo)

      attr = {
        owner_name: owner_and_repo.owner,
        repo_name: owner_and_repo.repo,
        description: response[:description],
        default_branch: response[:default_branch],
        watchers_count: response[:watchers_count],
        language: response[:language],
        repo_created_at: response[:created_at],
        repo_updated_at: response[:updated_at]
      }
      repository.update!(attr)
      repository.complete!
    rescue StandardError
      repository.fail!
    end
  end
end
