class Movie < ApplicationRecord
  default_scope { order(release_year: :asc) }
end
