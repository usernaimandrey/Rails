# frozen_string_literal: true

require 'faker'

10.times do |_i|
  Task.create(
    name: Faker::Lorem.word,
    description: Faker::Lorem.paragraph,
    status: %w[new closed].sample,
    creator: Faker::Name.name,
    performer: Faker::Name.name,
    completed: Faker::Boolean.boolean
  )
end
