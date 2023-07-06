class MovieService
  def search_movies(search_string)
    get_url("/search/movie?query=#{search_string}&include_adult=false&language=en-US&page=1")
  end

  def top_rated
    get_url("/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org/3") do |faraday|
      faraday.headers["Authorization"] = ENV["TMDB_API_KEY"]
    end
  end
end