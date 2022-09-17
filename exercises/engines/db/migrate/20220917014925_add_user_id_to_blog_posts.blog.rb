# frozen_string_literal: true

# This migration comes from blog (originally 20220917014843)
class AddUserIdToBlogPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :blog_posts, :user_id, :integer
  end
end
