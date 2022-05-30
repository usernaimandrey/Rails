# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def before_setup
    @stack = Stack.new(%w[1 2 3 4 5 6])
    @stack_default = Stack.new
  end

  def test_init_with_default_params
    assert(@stack_default.empty?)
    assert(@stack_default.to_a == [])
  end

  def test_init_with_params
    expected = %w[1 2 3 4 5 6]
    assert(@stack.empty? == false)
    assert(@stack.to_a == expected)
  end

  def test_push!
    expected = %w[1 2 3]
    @stack_default.push!('1')
    @stack_default.push!('2')
    @stack_default.push!('3')
    assert(@stack_default.to_a == expected)
  end

  def test_pop!
    @stack_default.push!(1)
    @stack_default.pop!
    assert_empty(@stack_default)

    @stack.pop!
    @stack.pop!
    expected = %w[1 2 3 4]
    assert(@stack.to_a == expected)
  end

  def test_size
    assert(@stack.size == 6)
    assert(@stack_default.size.zero?)
  end

  def test_clear!
    @stack.clear!
    @stack_default.clear!
    assert(@stack.to_a == [])
    assert(@stack_default.to_a == [])
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
