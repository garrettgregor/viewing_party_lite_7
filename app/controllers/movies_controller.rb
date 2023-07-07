# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :find_user

  def index
    if params[:q] == 'top 20rated'
      @facade = MovieFacade.new
      #   conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      #     faraday.params['api_key'] = '8c109ce19b63241d3fe4f0ddc932061b'
      #   end
      # response = conn.get('/3/movie/top_rated')

    else
      # search = params[:q]
      # conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      #   faraday.params['api_key'] = '8c109ce19b63241d3fe4f0ddc932061b'
      # end
      # response = conn.get("/3/search/movie?query=#{search}")
      @facade = MovieFacade.new(params[:q])

    end
    # data = JSON.parse(response.body, symbolize_names: true)
    # @movies = data[:results].map { |details| Movie.new(details) }
  end

  def show
    # conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
    #   faraday.params['api_key'] = '8c109ce19b63241d3fe4f0ddc932061b'
    # end
    # response = conn.get("/3/movie/#{params[:id]}")
    # data = JSON.parse(response.body, symbolize_names: true)

    # conn2 = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
    #   faraday.params['api_key'] = '8c109ce19b63241d3fe4f0ddc932061b'
    # end
    # response2 = conn2.get("/3/movie/#{params[:id]}/credits?language=en-US")
    # data2 = JSON.parse(response2.body, symbolize_names: true)

    # conn3 = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
    #   faraday.params['api_key'] = '8c109ce19b63241d3fe4f0ddc932061b'
    # end
    # response3 = conn3.get("/3/movie/#{params[:id]}/reviews")
    # data3 = JSON.parse(response3.body, symbolize_names: true)

    @facade = MovieFacade.new(params[:id])
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
