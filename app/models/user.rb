# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_parties, dependent: :restrict_with_error
  has_many :viewing_parties, through: :user_parties

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  def hosted_parties
    ViewingParty.where(:host_id == self.id)
  end

  def hosted_parties_ids
    hosted_parties.pluck(:movie_id)
  end
end
