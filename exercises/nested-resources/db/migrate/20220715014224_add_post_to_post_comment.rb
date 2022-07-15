# frozen_string_literal: true

class AddPostToPostComment < ActiveRecord::Migration[6.1]
  def change
    add_reference :post_comments, :post, null: false, foreign_key: true
  end
end
