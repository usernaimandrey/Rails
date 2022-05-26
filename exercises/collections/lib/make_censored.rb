# frozen_string_literal: true

def make_replacement(word, stub, stop_words)
  word = stub if stop_words.include?(word)
  word
end

def make_censored(text, stop_words)
  # BEGIN
  string_stub = '$#%!'
  text
    .split
    .map { |word| make_replacement(word, string_stub, stop_words) }
    .join(' ')
  # END
end
