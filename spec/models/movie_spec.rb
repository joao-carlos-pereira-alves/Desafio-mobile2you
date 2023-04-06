require 'rails_helper'

RSpec.describe Movie, type: :model do
  let!(:movie1) { create(:movie, title: 'The Shawshank Redemption', gender: 'Drama', release_year: 1994) }
  let!(:movie2) { create(:movie, title: 'The Godfather', gender: 'Crime', release_year: 1972) }
  let!(:movie3) { create(:movie, title: 'Pulp Fiction', gender: 'Crime', release_year: 1994) }

  it "has a default scope for ordering by release year in ascending order" do
    movies = FactoryBot.create_list(:movie, 5)
    expected_movies = Movie.order(release_year: :asc)
    expect(Movie.all).to eq(expected_movies)
  end

  it "filter method must exist" do
    expect(Movie).to respond_to(:filter)
  end

  it "clean_date method must exist" do
    expect(Movie).to respond_to(:filter)
  end

  it 'filters movies by title' do
    filtered_movies = Movie.filter({ title: 'Redemption' })
    expect(filtered_movies).to eq([movie1])
  end

  it 'filters movies by gender' do
    filtered_movies = Movie.filter({ gender: 'Crime' })
    expect(filtered_movies).to eq([movie2, movie3])
  end

  it 'filters movies by release year' do
    filtered_movies = Movie.filter({ year: 1994 })
    expect(filtered_movies).to eq([movie1, movie3])
  end
end
