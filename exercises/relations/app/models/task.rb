# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :status

  validates :name, :description, presence: true

  scope :last_tasks, -> { limit(15).order(created_at: :desc) }
end
