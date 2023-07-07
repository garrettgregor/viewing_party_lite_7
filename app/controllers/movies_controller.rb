# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :find_user

  def index
    if params[:q] == 'top 20rated'
      conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
        faraday.params['api_key'] = '8c109ce19b63241d3fe4f0ddc932061b'
      end
      response = conn.get('/3/movie/top_rated')

    else
      search = params[:q]
      conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
        faraday.params['api_key'] = '8c109ce19b63241d3fe4f0ddc932061b'
      end
      response = conn.get("/3/search/movie?query=#{search}")

    end
    data = JSON.parse(response.body, symbolize_names: true)
    @movies = data[:results].map { |details| Movie.new(details) }
  end

  def show; end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
