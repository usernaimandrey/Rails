# frozen_string_literal: true

class User < ApplicationRecord
  validates :first_name, presence: true
end
