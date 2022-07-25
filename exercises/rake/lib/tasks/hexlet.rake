# frozen_string_literal: true

require 'csv'

namespace :hexlet do
  desc 'Import users'
  task :import_users, [:path] => :environment do |_t, args|
    abort 'Error! File path not passed!' if args[:path].blank?

    abort 'Error! File not exist!' unless File.exist?(args[:path])

    print "#{'*' * 5} Taks start #{'*' * 5}\n"
    CSV.foreach(args[:path], headers: true, header_converters: :symbol) do |user|
      user[:birthday] = DateTime.strptime(user[:birthday], '%m/%d/%Y')
      User.create(user)
      print '.'
    end
    print "\n#{'*' * 5} ...Done! #{'*' * 5}\n"
  end
end

