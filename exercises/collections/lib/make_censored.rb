# frozen_string_literal: true

# rubocop:disable Style/For

def make_censored(text, stop_words)
  # BEGIN
  string_stub = '$#%!'
  text_to_arr = text.split
  result = []
  for word in text_to_arr do
    word = string_stub if stop_words.include?(word)
    result << word
  end
  result.join(' ')
  # END
end

# rubocop:enable Style/For
