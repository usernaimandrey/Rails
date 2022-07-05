# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, :status, :creator, presence: true
  validates :completed, acceptance: { accept: [true, false] }
  validates :name, length: { maximum: 15,
                             too_long: '%<count>s characters is the maximum allowed' }
  validates :description, length: { maximum: 100,
                                    too_long: '%<count>s characters is the maximum allowed' }
  validates :name, :status, :creator, :performer, format: { with: /\A[a-zA-Z\s]*\z/,
                                                            message: 'only allows letters' }
end
