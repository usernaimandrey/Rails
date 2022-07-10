# frozen_string_literal: true

require 'faker'

50.times do |_i|
  Post.create(
    title: Faker::Lorem.word,
    body: Faker::Lorem.paragraph,
    summary: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
    published: Faker::Boolean.boolean
  )
end
