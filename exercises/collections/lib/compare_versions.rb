# frozen_string_literal: true

# BEGIN
def compare_versions(ver1, ver2)
  maj1, min1 = ver1.split('.')
  maj2, min2 = ver2.split('.')
  result = maj1.to_i <=> maj2.to_i
  result.zero? ? min1.to_i <=> min2.to_i : result
end
# END
