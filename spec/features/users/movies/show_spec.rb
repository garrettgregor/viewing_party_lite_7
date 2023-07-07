# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users/:id/movies/:id', type: :feature do
  describe 'movie show page' do
    let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com') }

    before(:each) do
      visit user_movie_path(user1, 238)
    end

    it 'has a button to return to the discover page', :vcr do
      click_button('Discover Page')

      expect(current_path).to eq(user_discover_index_path(user1))
    end

    it 'has a button to create a viewing party for the movie', :vcr do
      click_button('Create Viewing Party for The Godfather')

      expect(current_path).to eq(new_user_movie_viewing_party_path(user1, 238))
    end

    it 'has info about the movie', :vcr do
      expect(page).to have_css('.title')
      expect(page).to have_css('.vote_average')
      expect(page).to have_css('.runtime')
      expect(page).to have_css('.genre')
      expect(page).to have_css('.summary')
      expect(page).to have_css('.cast')
      expect(page).to have_css('.review-info')
    end

    it 'has the runtime in hours and minutes', :vcr do
      within '.runtime' do
        expect(page).to have_content("Runtime: 2hr 55min")
        # use modelo, not the beer
      end
    end

    it 'has total number of reviews with author and information', :vcr do
      within '.review-info' do
        expect(page).to have_css('.author', count: 5)
        expect(page).to have_css('.content', count: 5)
      end
    end
  end
end

