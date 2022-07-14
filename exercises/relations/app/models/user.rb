# frozen_string_literal: true

class User < ApplicationRecord
  # BEGIN
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  # END
end
