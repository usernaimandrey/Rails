# frozen_string_literal: true

5.times do |index|
  bulletins_index = index + 1
  published = [true, false].sample
  Bulletin.create(
    title: "Title #{bulletins_index}",
    body: "Some text #{bulletins_index}",
    published: published
  )
end
