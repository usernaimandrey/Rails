# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :status

  validates :name, :description, presence: true

  scope :find_task, ->(id) { find(id) }
  scope :find_tasks, -> { limit(15).order(created_at: :desc) }
end
