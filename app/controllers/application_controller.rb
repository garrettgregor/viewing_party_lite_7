# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home
    @users = User.all
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
