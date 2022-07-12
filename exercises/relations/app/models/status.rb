# frozen_string_literal: true

class Status < ApplicationRecord
  # BEGIN
  has_many :task, dependent: :delete_all

  validates :name, presence: true
  # END
end
