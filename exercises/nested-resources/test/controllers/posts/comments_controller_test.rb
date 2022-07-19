# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @comment = post_comments(:one)
  end

  test '#create' do
    comment = {
      body: 'this is comment',
      post_id: @post.id
    }

    post post_comments_path(@post), params: { post_comment: comment }
    new_comment = Post::Comment.find_by(comment)

    assert { new_comment }
    assert_redirected_to post_path(@post)
  end

  test '#create with not valid' do
    comment = {
      body: nil,
      post_id: @post.id
    }
    post post_comments_path(@post), params: { post_comment: comment }
    assert_response 422
    new_comment = Post::Comment.find_by(comment)
    assert_not(new_comment)
  end

  test '#edit' do
    get edit_post_comment_path(@post, @comment)

    assert_response :success
  end

  test '#update' do
    params_update = { body: 'lalalala' }
    patch post_comment_path(@post, @comment), params: { post_comment: params_update }
    update_comment = @comment.reload

    assert_redirected_to post_path(@post)
    assert_equal(update_comment.body, params_update[:body])
  end

  test '#destroy' do
    post = posts(:one)
    delete post_comment_path(@post, @comment)
    delete_comment = Post::Comment.find_by(id: @comment)

    assert_not(delete_comment)
    assert_redirected_to post_path(post)
  end
end
