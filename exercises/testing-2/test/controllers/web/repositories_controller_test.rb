# frozen_string_literal: true

require 'test_helper'

module Web
  class RepositoriesControllerTest < ActionDispatch::IntegrationTest
    # BEGIN
    setup do
      @api = 'https://api.github.com'
      @owner = 'users'
      @repo = 'octocat'
      @attr = {
        link: "https://github.com/#{@owner}/#{@repo}"
      }
    end

    test 'should create' do
      github_response = load_fixture('files/response.json')
      stub_url = "#{@api}/repos/#{@owner}/#{@repo}"

      stub_request(:get, stub_url)
        .to_return(
          headers: { 'Content-Type': 'application/json' },
          status: 200,
          body: github_response
        )

      post repositories_path, params: { repository: @attr }

      new_repo = Repository.find_by(@attr)

      assert { new_repo.owner_name == @owner }
      assert { new_repo.repo_name == @repo }
      assert { new_repo }
      assert_redirected_to new_repo
    end

    test 'create with bad link' do
      attr = {
        link: "https://github.com/#{@owner}"
      }
      stub_request(:get, @api)
        .to_return(
          status: [422, 'Validation error']
        )

      post repositories_path, params: { repository: attr }

      assert_not(Repository.find_by(attr))
      assert_redirected_to new_repository_path
    end

    test '#index' do
      get root_path

      assert_response :success
    end

    test '#show' do
      repo = repositories(:one)
      get repository_path(repo)

      assert_response :success
    end

    test '#new' do
      get new_repository_path

      assert_response :success
    end

    test '#edit' do
      repo = repositories(:one)
      get edit_repository_path(repo)

      assert_response :success
    end

    test '#update' do
      repo = repositories(:one)
      patch repository_path(repo), params: { repository: @attr }
      repo.reload

      assert_redirected_to repositories_path
      assert { repo.link == @attr[:link] }
    end

    test '#destoy' do
      repo = repositories(:one)
      delete repository_path(repo)

      assert_redirected_to repositories_path
      assert_not(Repository.find_by(id: repo.id))
    end
    # END
  end
end
