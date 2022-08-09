# frozen_string_literal: true

require 'open-uri'

class Hacker
  class << self
    def hack(email, password)
      # BEGIN
      hostname = 'https://rails-collective-blog-ru.hexlet.app'
      get_path = '/users/sign_up'
      post_path = '/users'
      response = sign_up_page(URI.join(hostname, get_path))
      token = parse_token(response.body)
      cookie = response.response['set-cookie'].split('; ')[0]
      params = {
        authenticity_token: token,
        user: {
          email: email,
          password: password,
          password_confirmation: password
        },
        commit: 'Регистрация'
      }

      response = sign_up(hostname, post_path, params, cookie)
      message = response.code.to_i == 302 ? 'Registration completed successfully' : 'Registration faled'
      p message
    end

    def sign_up_page(uri)
      http = setup_ssl(uri)
      request = Net::HTTP::Get.new uri
      http.request request
    end

    def sign_up(hostname, post_path, params, cookie)
      uri = URI.join(hostname, post_path)
      request = Net::HTTP::Post.new uri
      http = setup_ssl(uri)

      request.body = Rack::Utils.build_nested_query(params)
      request['Cookie'] = cookie

      http.request request
    end

    def setup_ssl(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def parse_token(page)
      html = Nokogiri::HTML(page)
      token_tag = html.at('input[@name="authenticity_token"]')
      token_tag['value']
    end
    # END
  end
end
