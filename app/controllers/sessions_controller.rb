class SessionsController < ApplicationController
  def login_form; end

  def login
    user = User.find_by(email: params[:email])
    if !user.nil? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = 'Sorry, your credentials are invalid.'
      render :login_form
    end
  end

  def logout
    reset_session
    redirect_to root_path
  end
end