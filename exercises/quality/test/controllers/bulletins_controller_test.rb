# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get bulletins_path

    assert_response :success
    assert_select 'h1', 'Bulletins'
    assert_select 'h2', 'Title1'

    assert_no_match 'Title2', @response.body
  end

  test 'should show article' do
    get bulletin_path(bulletins(:published))

    assert_response :success
    assert_select 'h2', 'Title1'
    assert_select 'p', 'Body1'
  end

  test 'not should show article' do
    assert_raises(ActiveRecord::RecordNotFound) do
      get bulletin_path(bulletins(:unpublished))
    end
  end
end
