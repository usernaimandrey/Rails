# frozen_string_literal: true

# BEGIN
def swap_the_element!(coll, step_count)
  index = 0
  swaped = false
  while index < step_count
    swaped = (coll[index] <=> coll[index + 1]).positive?
    coll[index], coll[index + 1] = coll[index + 1], coll[index] if swaped
    index += 1
  end
  swaped
end

def buble_sort!(coll)
  step_count = coll.size - 1
  swaped = nil
  loop do
    swaped = false
    swaped = swap_the_element!(coll, step_count)
    step_count -= 1
    break unless swaped
  end
  coll
end

def build_query_string(list_params)
  return '' if list_params.empty?

  sorted_keys = buble_sort!(list_params.keys)
  sorted_keys
    .map { |key| "#{key}=#{list_params[key]}" }
    .join('&')
end

# Альтернативный короткий вариан
# def build_query_string(list_params)
#   return '' if list_params.empty?
#   list_params
#     .to_a
#     .sort
#     .map { |param| param.join('=') }
#     .join('&')
# end
# END
