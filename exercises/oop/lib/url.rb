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
    url == other.url
  end

  def query_params
    to_h(params_formated(url))
  end

  def query_param(key, default = nil)
    params = query_params
    params.fetch(key, default)
  end

  protected

  def params_formated(params)
    return [] unless params.query

    params.query.split('&').map { |param| param.split('=') }
  end

  def to_h(arr)
    arr.each_with_object({}) do |param, acc|
      key, value = param
      acc[key.to_sym] ||= value
    end
  end
end
# END
