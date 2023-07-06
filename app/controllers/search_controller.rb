class SearchController < ApplicationController
  def index
    @facade = SearchFacade.new(params[:q])
  end

  def search
    conn = Faraday.new(url: "https://api.themoviedb.org/") do |faraday|
      faraday.headers["Authorization"] = ENV["TMDB_API_KEY"]
    end
    response = conn.get("/3/search/movie")

    data = JSON.parse(response.body, symbolize_names: true)

    movies = data[:results][0]

    found_movies = movies.find_all {|f| f[:title] == params[:q]}
    @movie = found_movies.first
    render user_movies_path
  end
end