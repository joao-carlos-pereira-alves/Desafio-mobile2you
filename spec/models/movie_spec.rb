# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  let!(:movie1) { create(:movie, title: 'The Shawshank Redemption', gender: 'Drama', release_year: 1994) }
  let!(:movie2) { create(:movie, title: 'The Godfather', gender: 'Crime', release_year: 1972) }
  let!(:movie3) { create(:movie, title: 'Pulp Fiction', gender: 'Crime', release_year: 1994) }

  it "has a default scope for ordering by release year in ascending order" do
    movies = FactoryBot.create_list(:movie, 5)
    expected_movies = described_class.order(release_year: :asc)
    expect(described_class.all).to eq(expected_movies)
  end

  it "filter method must exist" do
    expect(described_class).to respond_to(:filter)
  end

  it "clean_date method must exist" do
    expect(described_class).to respond_to(:clean_date)
  end

  it 'filters movies by title' do
    filtered_movies = described_class.filter({ title: 'Redemption' })
    expect(filtered_movies).to eq([movie1])
  end

  it 'filters movies by gender' do
    filtered_movies = described_class.filter({ gender: 'Crime' })
    expect(filtered_movies).to eq([movie2, movie3])
  end

  it 'filters movies by release year' do
    filtered_movies = described_class.filter({ year: 1994 })
    expect(filtered_movies).to eq([movie1, movie3])
  end

  it "returns the date in yyyy-mm-dd format" do
    date_string = "31-12-2023"
    expected_result = "2023-12-31"
    result = described_class.clean_date(date_string)
    expect(result).to eq(expected_result)
  end

  it "returns the date in yyyy-mm-dd format" do
    date_string = "31/12/2023"
    expected_result = "2023-12-31"
    result = described_class.clean_date(date_string)
    expect(result).to eq(expected_result)
  end

  context "when the date is in dd-mm-yyyy format" do
    it "returns the date in yyyy-mm-dd format" do
      date_string = "31-12-2023"
      expected_result = "2023-12-31"
      result = described_class.clean_date(date_string)
      expect(result).to eq(expected_result)
    end
  end

  context "when the date is in dd/mm/yyyy format" do
    it "returns the date in yyyy-mm-dd format" do
      date_string = "31/12/2023"
      expected_result = "2023-12-31"
      result = described_class.clean_date(date_string)
      expect(result).to eq(expected_result)
    end
  end

  context "when the date is in an invalid format" do
    it "raises an ArgumentError" do
      date_string = "31-12/2023"
      expect { described_class.clean_date(date_string) }.to raise_error(ArgumentError, /Invalid date format/)
    end
  end

  describe "validations" do
    context "when title is not unique" do
      before do
        described_class.create(title: "13 Reasons Why")
      end

      it "is not valid" do
        record = described_class.new(title: "13 Reasons Why")
        expect(record).not_to be_valid
      end

      it "has a validation error" do
        record = described_class.new(title: "13 Reasons Why")
        record.valid?
        expect(record.errors[:title]).to include("já está em uso")
      end
    end

    context "when title is unique" do
      it "is valid" do
        record = described_class.new(title: "13 Reasons Why")
        expect(record).to be_valid
      end
    end
  end
end
