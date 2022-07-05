# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  test 'should get home_page' do
    get root_path

    assert_response :success
  end
end
