class Movie < ApplicationRecord
  default_scope { order(release_year: :asc) }

  validates :title, uniqueness: true

  def self.filter(params, movies = Movie.all)
    filter_params = [
      [:title, ->(value) { ["title ILIKE ?", "%#{value}%"] }],
      [:gender, ->(value) { ["gender ILIKE ?", "%#{value}%"] }],
      [:country, ->(value) { ["country ILIKE ?", "%#{value}%"] }],
      [:director, ->(value) { ["director ILIKE ?", "%#{value}%"] }],
      [:duration, ->(value) { ["duration ILIKE ?", "%#{value}%"] }],
      [:rating, ->(value) { ["rating ILIKE ?", "%#{value}%"] }],
      [:published_at, ->(value) { ["date_added = ?", clean_date(value) ] }],
      [:year, ->(value) { ["release_year::integer = ?", value] }],
      [:description, ->(value) { ["description ILIKE ?", "%#{value}%"] }],
      [:listed_in, ->(value) { ["listed_in ILIKE ?", "%#{value}%"] }],
      [:cast, ->(value) { ["cast ILIKE ?", "%#{value}%"] }],
      [:created_at, ->(value) { ["created_at = ?", clean_date(value) ] }],
      [:updated_at, ->(value) { ["updated_at = ?", clean_date(value) ] }]
    ]

    filter_params.reduce(movies) do |relation, (key, filter)|
      if params[key].present?
        relation.where(*filter.call(params[key]))
      else
        relation
      end
    end
  end

  def self.clean_date(date_string)
    if date_string =~ /^\d{2}-\d{2}-\d{4}$/
      date = Date.strptime(date_string, "%d-%m-%Y")
      date_string = date.strftime("%Y-%m-%d")
    elsif date_string =~ /^\d{2}\/\d{2}\/\d{4}$/
      date = Date.strptime(date_string, "%d/%m/%Y")
      date_string = date.strftime("%Y-%m-%d")
    else
      raise ArgumentError, "Invalid date format: #{date_string}. Please use dd-mm-yyyy or dd/mm/yyyy format."
    end
    date_string
  end
end
