# frozen_string_literal: true

json.array! @movies, partial: "api/v1/movies/movie", as: :movie
