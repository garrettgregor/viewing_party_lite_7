# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :find_user

  def index
    @facade = if params[:q] == 'top 20rated'
                MovieFacade.new
              else
                MovieFacade.new(params[:q])
              end
  end

  def show
    @movie_facade = MovieFacade.new(params[:id])
    @credit_facade = CreditFacade.new(params[:id])
    @review_facade = ReviewFacade.new(params[:id])
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
