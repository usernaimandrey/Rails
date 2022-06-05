# frozen_string_literal: true

# BEGIN
require 'forwardable'
require 'uri'

class Url
  attr_reader :url

  include Comparable

  extend Forwardable

  def initialize(url)
    @url = URI url
  end

  def_delegators :url, :scheme, :host, :to_s

  def ==(other)
    to_s == other.to_s
  end

  def query_params
    return {} unless url.query

    @query_params ||= memoize
  end

  def query_param(key, default = nil)
    params = query_params
    params.fetch(key, default)
  end

  protected

  def memoize
    url.query.split('&').each_with_object({}) do |param, acc|
      key, value = param.split('=')
      acc[key.to_sym] ||= value
    end
  end
end
# END
