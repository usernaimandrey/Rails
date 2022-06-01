# frozen_string_literal: true

# BEGIN
def anagramm_filter(word, list)
  sorted = word.chars.sort
  list.select { |item| sorted == item.chars.sort }
end
# END
