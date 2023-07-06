class SearchFacade
  def initialize(movie)
    @movie = movie
  end

  def movies
    service = MovieService.new

    json = service.search_movies(@movie)

    @movies = json[:results].map do |movie_data|
      movie.new(movie_data)
    end
  end
end