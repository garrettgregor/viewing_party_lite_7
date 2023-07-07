class MovieFacade
  def initialize(search=nil)
    @search = search
  end

  def movies_index
    # conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
    #   faraday.params['api_key'] = '8c109ce19b63241d3fe4f0ddc932061b'
    # end

    # response = conn.get('/3/movie/top_rated')

    # data = JSON.parse(response.body, symbolize_names: true)
    service = MovieService.new
    
    if @search.nil?
      json = service.top_rated_movies
    else
      json = service.movie_by_search(@search)
    end
    

    @movies = json[:results].map { |details| Movie.new(details) }
  end

  def movie_show
    service = MovieService.new
    details = service.movie_details(@search)
    credits = service.movie_credits(@search)
    reviews = service.movie_reviews(@search)

    @movie = Movie.new(details, credits, reviews)
  end
end