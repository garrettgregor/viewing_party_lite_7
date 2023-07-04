class ViewingParty < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties
end