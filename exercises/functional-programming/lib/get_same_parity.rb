# frozen_string_literal: true

# BEGIN
class Array
  def iter(acc, coll, &block)
    return acc if coll.empty?

    head, *tail = coll
    acc << head if yield(head)
    iter(acc, tail, &block)
  end

  def my_filter(&block)
    iter([], self, &block)
  end
end

def get_same_parity(list)
  return list if list.empty?

  first_element = list.first
  list.my_filter { |el| el.even? == first_element.even? }
end
# END
