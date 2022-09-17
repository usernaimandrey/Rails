# frozen_string_literal: true

class AddUserIdToBlogPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :blog_posts, :user_id, :integer
  end
end
