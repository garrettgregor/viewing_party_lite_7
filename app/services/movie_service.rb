# frozen_string_literal: true

class MovieService
  def top_rated_movies
    get_url('/3/movie/top_rated')
  end

  def movie_by_search(search)
    get_url("/3/search/movie?query=#{search}")
  end

  def movie_details(movie_id)
    get_url("/3/movie/#{movie_id}")
  end

  def movie_credits(movie_id)
    get_url("/3/movie/#{movie_id}/credits?language=en-US")
  end

  def movie_reviews(movie_id)
    get_url("/3/movie/#{movie_id}/reviews")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.params['api_key'] = ENV['TMDB_API_KEY']
    end
  end
end
