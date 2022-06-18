# frozen_string_literal: true

class AdminPolicy
  def initialize(app) # :nodoc:
    @app = app
  end

  def call(env)
    # BEGIN
    time_start = (Time.new.to_f * 1_000_000).to_i
    env['TIME_START'] = time_start
    status, headers, body = @app.call(env)
    request = Rack::Request.new(env)
    if request.path.start_with?('/admin')
      [403, headers, ['Forbidden']]
    else
      [status, headers, body]
    end
    # END
  end
end
