# frozen_string_literal: true

class MovieService
  def top_rated_movies
    get_url('/movie/top_rated?limit=20')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.themoviedb.org/3') do |faraday|
      faraday.params['api_key'] = '8c109ce19b63241d3fe4f0ddc932061b'
    end
  end
end
