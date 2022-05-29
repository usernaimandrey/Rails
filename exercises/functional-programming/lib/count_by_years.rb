# frozen_string_literal: true

# BEGIN
def count_by_years(users)
  predecat = proc { |user| user[:gender] == 'male' }
  users
    .filter(&predecat)
    .each_with_object({}) do |user, acc|
      key = user[:birthday].split('-')[0]
      acc[key] ||= 0
      acc[key] += 1
    end
end
# END
