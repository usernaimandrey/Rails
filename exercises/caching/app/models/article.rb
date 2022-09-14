# frozen_string_literal: true

class Article < ApplicationRecord
  # BEGIN
  validates :title, :summary, :body, :published_at, presence: true

  def last_reading_date
    Rails.cache.fetch("#{cache_key_with_version}/last_reading_date", expires_in: 12.hours) do
      updated_at
    end
  end
  # END
end
