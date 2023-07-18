# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users/:id/discover', type: :feature do
  describe 'discover page' do
    let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com', password: 'test') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com', password: 'test') }

    before(:each) do
      visit user_discover_index_path(user1)
    end

    it 'has a button to discover top rated movies', :vcr do
      within '.top-movies' do
        click_button('Find Top Rated Movies')
        expect(current_path).to eq(user_movies_path(user1))
      end
    end

    it 'has a text field to enter keyworkd(s) to search by movie title' do
      within '.search-movies' do
        fill_in('Search:', with: 'Fight Club')
      end
    end

    it 'has a button to search by movie title', :vcr do
      within '.search-movies' do
        fill_in('Search:', with: 'Fight Club')
        click_button('Find Movies')
        expect(current_path).to eq(user_movies_path(user1))
      end
    end
  end
end
