# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home
    @users = User.all
  end
end
