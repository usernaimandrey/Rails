# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require_relative '../app/services/git_hub_service'

# BEGIN
require 'webmock/minitest'

WebMock.disable_net_connect!
# END

module ActiveSupport
  class TestCase
    include RepositoriesConcern

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def load_fixture(filename)
      File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
    end

    def select_methods_starts_with(test_instance, substr)
      test_instance.methods.select { |method| method.start_with? substr }
    end
  end
end
