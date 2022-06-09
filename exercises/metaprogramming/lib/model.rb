# frozen_string_literal: true

# BEGIN
module Model
  def self.included(base)
    base.extend(ClassMethod)
  end

  def convert_by_type(value, type)
    return value if value.nil?

    case type
    when :string then value.to_s
    when :integer then value.to_i
    when :boolean then value != false
    when :datetime then DateTime.parse(value)
    else puts "Undefined type = #{type}"
    end
  end

  module ClassMethod # :nodoc:
    attr_reader :schema

    def update_schema(name, options)
      @schema ||= {}
      @schema[name] = options
    end

    def attribute(name, options = {})
      attr_reader name

      update_schema(name, options)

      define_method "#{name}=" do |value|
        type = options.fetch(:type, nil)
        current_value = convert_by_type(value, type)
        instance_variable_set "@#{name}", current_value
      end
    end
  end

  def initialize(attributes = {})
    @schema = self.class.schema
    @schema.each_key do |k|
      options = @schema[k.to_sym]
      attribut = attributes[k.to_sym] || options[:default]
      send "#{k}=", attribut
    end
  end

  def attributes
    @schema.keys.each_with_object({}) do |m, acc|
      acc[m.to_sym] ||= send m
    end
  end
end
# END
