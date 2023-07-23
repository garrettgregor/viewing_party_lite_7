# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:name] = user[:name].downcase
    new_user = User.new(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.name}!"
      redirect_to user_path(new_user)
    else
      redirect_to register_path
      flash[:alert] = "Error: #{error_message(new_user.errors)}"
    end
  end

  def show
    if current_user
      @user = current_user
      @movie_facade = MovieFacade.new(params[:id])
    else
      redirect_to root_path
      flash[:alert] = 'You must be logged in to view that page'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
