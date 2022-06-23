# frozen_string_literal: true

require 'rack'

class ExecutionTimer # :nodoc:
  def initialize(app)
    @app = app
  end

  def call(env)
    time_start = (Time.new.to_f * 1_000_000).to_i

    status, headers, body = @app.call(env)

    time_stop = (Time.new.to_f * 1_000_000).to_i
    puts "Request processing time: #{time_stop - time_start} µs"
    [status, headers, body]
  end
end
