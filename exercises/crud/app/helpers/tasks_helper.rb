# frozen_string_literal: true

module TasksHelper
  def render_error(errors)
    errors.join(', ')
  end
end
