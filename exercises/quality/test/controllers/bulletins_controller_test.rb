# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get bulletins_path

    assert_response :success
    assert_select 'h1', 'Bulletins'
    assert_select 'h2', 'Title1'
    assert_select 'h2', 'Title3'
  end

  test 'should show article' do
    get bulletin_path(bulletins(:bulletin_1))

    assert_response :success
    assert_select 'h2', 'Title1'
    assert_select 'p', 'Body1'
  end
end
