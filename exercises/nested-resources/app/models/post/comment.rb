# frozen_string_literal: true

class Post
  class Comment < ApplicationRecord
    belongs_to :post

    validates :body, presence: true, length: { minimum: 5 }
  end
end
