# frozen_string_literal: true

class MovieFacade
  def initialize(search = nil)
    @search = search
  end

  def movies_index
    service = MovieService.new

    json = if @search.nil?
             service.top_rated_movies
           else
             service.movie_by_search(@search)
           end

    @movies = json[:results].map { |details| Movie.new(details) }
  end

  def movie_details_show
    service = MovieService.new
    details = service.movie_details(@search)

    @movie = Movie.new(details)
  end

  def user_hosted_parties
    service = MovieService.new
    details = @search.map do |movie_id|
      service.movie_details(movie_id)
    end

    @movies = details.map { |movie_details| Movie.new(movie_details) }
  end
end
