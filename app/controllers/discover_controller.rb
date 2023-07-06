# frozen_string_literal: true

class DiscoverController < ApplicationController
  before_action :find_user

  def index; end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
