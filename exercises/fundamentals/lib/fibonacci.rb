# frozen_string_literal: true

# BEGIN
def fibonacci(num)
  return nil if num.negative?

  first = 0
  second = 1
  return first if num.zero?

  result = 1
  index = 2
  while index <= num
    result = first + second
    first = second
    second = result
    index += 1
  end
  result
end
# END
