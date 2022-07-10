# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, :body, :summary, presence: true
  validates :published, acceptance: { accept: [true, false] }
end
