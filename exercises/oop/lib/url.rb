# frozen_string_literal: true

# BEGIN
require 'forwardable'
require 'uri'

class Url
  attr_reader :url

  include URI

  include Comparable

  extend Forwardable

  def initialize(url)
    @url = URI url
  end

  def_delegators :url, :scheme, :host

  def ==(other)
    url.to_s == other.url.to_s
  end

  def query_params
    return {} unless url.query

    memoize(url)
  end

  def query_param(key, default = nil)
    params = query_params
    params.fetch(key, default)
  end

  def memoize(url)
    return @memo if @memo

    @memo = url.query.split('&').each_with_object({}) do |param, acc|
      key, value = param.split('=')
      acc[key.to_sym] ||= value
    end
  end
end
# END
