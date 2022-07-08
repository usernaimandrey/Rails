# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, :status, :creator, presence: true
  validates :completed, acceptance: { accept: [true, false] }
end
