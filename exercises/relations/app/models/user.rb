# frozen_string_literal: true

class User < ApplicationRecord
  # BEGIN
  has_many :tasks, dependent: :delete_all

  validates :name, presence: true
  # END
end
