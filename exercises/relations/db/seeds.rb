# frozen_string_literal: true

require 'faker'

4.times do |_i|
  User.create(
    name: Faker::Name.first_name
  )
end

statuses_name = %w[New InProgres Closed]

statuses_name.each do |status|
  Status.create(
    name: status
  )
end

users = User.all
statuses = Status.all

10.times do |_i|
  Task.create(
    name: Faker::Lorem.word,
    description: Faker::Lorem.paragraph,
    user: users.sample,
    status: statuses.sample
  )
end
