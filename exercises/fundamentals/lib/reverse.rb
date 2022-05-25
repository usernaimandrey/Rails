# frozen_string_literal: true

# BEGIN
def reverse(str)
  result = ''
  index = 0
  while index <= str.size - 1
    result = "#{str[index]}#{result}"
    index += 1
  end
  result
end
# END
