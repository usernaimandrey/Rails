# frozen_string_literal: true

require 'csv'

namespace :hexlet do
  desc 'Import users'
  task :import_users, [:path] => :environment do |_t, args|
    print "#{'*' * 5} Taks start #{'*' * 5}\n"
    users = CSV.read(args[:path])
    users[1..].each do |user|
      first_name, last_name, birthday, email = user
      month, day, year = birthday.split('/')
      User.create(
        first_name: first_name,
        last_name: last_name,
        birthday: "#{day}.#{month}.#{year}",
        email: email
      )
      print '.'
    end
    print "\n#{'*' * 5} ...Done! #{'*' * 5}\n"
  end
end
