# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    I18n.locale = if env['HTTP_ACCEPT_LANGUAGE'].present?
                    extract_locale_from_accept_language_header(env)
                  else
                    I18n.default_locale
                  end

    @app.call(env)
  end

  private

  def extract_locale_from_accept_language_header(env)
    env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
  # END
end
