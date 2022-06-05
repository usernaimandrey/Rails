# frozen_string_literal: true

# BEGIN
module Model
  def self.included(base)
    base.extend(ClassMethod)
  end

  module ClassMethod # :nodoc:
    def process
      {
        string: ->(name) { name.to_s },
        integer: ->(name) { name.to_i },
        boolean: lambda do |name|
          return true if name == 'true'

          return false if name == 'false'

          name
        end,
        datetime: ->(name) { DateTime.parse(name) }
      }
    end

    def attribute(name, options = {})
      attr_reader name

      function = process
      define_method "#{name}=" do |value|
        type = options.fetch(:type, nil)
        current_value = !type.nil? && !value.nil? ? function[type].call(value) : value
        instance_variable_set "@#{name}", current_value
      end
      define_method("get@opt@#{name}".to_sym) { options[:default] }
    end
  end

  def initialize(arg = {})
    @instance_methods = instance_method
    @instance_methods.each_key do |k|
      attribut = arg[k.to_sym] || (send "get@opt@#{k}")
      send "#{k}=", attribut
    end
  end

  def attributes
    @instance_methods.keys.each_with_object({}) do |m, acc|
      acc[m.to_sym] ||= send m
    end
  end

  def instance_method
    methods
      .filter { |m| m.to_s.include? 'get@opt' }
      .each_with_object({}) do |m, acc|
        v = m.to_s.split('@').last.to_sym
        acc[v] ||= v
      end
  end
end
# END
