# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_parties, dependent: :restrict_with_error
  has_many :viewing_parties, through: :user_parties

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :password_digest, presence: true

  has_secure_password

  def hosted_parties
    ViewingParty.where('viewing_parties.host_id = ?', id)
  end
end
