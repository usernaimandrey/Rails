# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :address, :full_name

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  has_many :posts
end
