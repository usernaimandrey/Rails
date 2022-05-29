# frozen_string_literal: true

# BEGIN
def count_by_years(users)
  predecate = proc { |user| user[:gender] == 'male' }
  users
    .filter(&predecate)
    .each_with_object({}) do |user, acc|
      key = user[:birthday].split('-')[0]
      acc[key] ||= 0
      acc[key] += 1
    end
end
# END
