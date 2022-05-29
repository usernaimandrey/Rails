# frozen_string_literal: true

# BEGIN
def generate_predecate
  proc do |test_word|
    proc do |word|
      test_word.chars.sort == word.chars.sort
    end
  end
end

def anagramm_filter(word, list)
  predecate = generate_predecate.call(word)
  list.select(&predecate)
end
# END
