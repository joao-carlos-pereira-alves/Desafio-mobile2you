require 'csv'

module Api
  module V1
    # Movies Controller
    class MoviesController < ApplicationController
      before_action :set_movie, only: %i[ show update destroy ]

      # GET /movies
      # GET /movies.json
      def index
        @movies = Movie.all
        @movies = Movie.filter(params, @movies) if filter_params_present?
        @movies = @movies.distinct
      end

      # GET /movies/1
      # GET /movies/1.json
      def show
      end

      # POST /movies
      # POST /movies.json
      def create
        @movie = Movie.new(movie_params)

        if @movie.save
          render :show, status: :created
        else
          render json: @movie.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /movies/1
      # PATCH/PUT /movies/1.json
      def update
        if @movie.update(movie_params)
          render :show, status: :ok
        else
          render json: @movie.errors, status: :unprocessable_entity
        end
      end

      def import
        file_path =        Rails.root.join('db', 'netflix_titles.csv')
        file =             File.read(file_path)
        permitted_params = Movie.new.attributes.keys

        Movie.transaction do
          CSV.parse(file, headers: true) do |row|
            movie_hash = row.to_h.slice(*permitted_params)
            movie = Movie.new(movie_hash)

            movie.save! if movie.valid?
          end
        end

        render json: { message: "#{Movie.count} movies imported successfully." }
      end

      # DELETE /movies/1
      # DELETE /movies/1.json
      def destroy
        @movie.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_movie
          @movie = Movie.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def movie_params
          params.require(:movie).permit(:title, :gender, :release_year, :country, :director, 
                                        :duration, :rating, :date_added, :description, 
                                        :listed_in, :cast, :updated_at)
        end

        def filter_params_present?
          params.slice(:title, :gender, :year, :country, :director, 
                       :duration, :rating, :published_at, :description, 
                       :listed_in, :cast, :updated_at
                      ).values.compact.any?
        end
    end
  end
end