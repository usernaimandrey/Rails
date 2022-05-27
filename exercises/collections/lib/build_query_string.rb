# frozen_string_literal: true

# rubocop:disable Style/For
# BEGIN
def build_query_string(list_params)
  return '' if list_params.empty?

  sorted_keys = list_params.keys.sort
  result = []
  for key in sorted_keys do
    query = "#{key}=#{list_params[key]}"
    result << query
  end
  result.join('&')
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
# rubocop:enable Style/For
