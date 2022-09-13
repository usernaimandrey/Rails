# frozen_string_literal: true

class GitHubService
  class << self
    def call(id)
      repository = Repository.find_by(id: id)
      repository.fetch
      repository.save
      owner_and_repo = Octokit::Repository.from_url(repository.link)

      response = Octokit::Client.new.repo(
        owner: owner_and_repo.owner,
        repo: owner_and_repo.repo
      )

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
      repository.update(attr)
      repository.complet
      repository.save
    rescue StandardError
      repository.fail
      repository.save
    end
  end
end
