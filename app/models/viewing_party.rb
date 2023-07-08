# frozen_string_literal: true

class ViewingParty < ApplicationRecord
  has_many :user_parties, dependent: :restrict_with_error
  has_many :users, through: :user_parties

  def host_name
    User.find(self.host_id).name
  end
end
