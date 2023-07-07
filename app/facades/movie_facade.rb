class MovieFacade
  def initialize(search=nil)
    @search = search
  end

  def movies_index
    service = MovieService.new
    
    if @search.nil?
      json = service.top_rated_movies
    else
      json = service.movie_by_search(@search)
    end
    
    @movies = json[:results].map { |details| Movie.new(details) }
  end

  def movie_details_show
    service = MovieService.new
    details = service.movie_details(@search)

    @movie = Movie.new(details)
  end
end