# frozen_string_literal: true

# BEGIN
def fizz_buzz(start, stop)
  return nil if stop < start

  index = start
  result = ''
  while index <= stop
    has_fizz = (index % 3).zero?
    has_buzz = (index % 5).zero?

    fizz_part = has_fizz ? 'Fizz' : nil
    buzz_part = has_buzz ? 'Buzz' : nil

    part = fizz_part || buzz_part ? "#{fizz_part}#{buzz_part}" : index
    result = "#{result}#{part} "
    index += 1
  end
  result.strip
end

# def fizz_buzz start, stop
#   return nil if stop < start

#   print_fizz_buzz = lambda {|i|

#     return 'FizzBuzz' if (i % 3).zero? && (i % 5).zero?

#     return 'Fizz' if (i % 3).zero?

#     return 'Buzz' if (i % 5).zero?

#     return i unless ((i % 3).zero? && (i % 5).zero?)

#   }

#   (start..stop).to_a.map(&print_fizz_buzz).join(' ')
# end
# END
