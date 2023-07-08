# frozen_string_literal: true

class ViewingPartiesController < ApplicationController
  before_action :find_user

  def new
    @movie_facade = MovieFacade.new(params[:movie_id])
    @users = User.excluding(@user)
  end

  def create
    viewing_party = ViewingParty.create!(viewing_party_params)
    # refactor this to move to model or facade?
    params[:user_ids].each do |id|
      UserParty.create!(user_id: id,
                        viewing_party_id: viewing_party.id
                      )
    end
    redirect_to user_path(@user)
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def viewing_party_params
    params.permit(:duration,
                  :start_date,
                  :start_time,
                  :movie_id,
                  :host_id
                )
  end
end
