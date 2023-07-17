# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users/:id/movies', type: :feature do
  describe 'top movies results page' do
let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com', password: 'test') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com', password: 'test') }

    before(:each) do
      visit user_discover_index_path(user1)
      click_button 'Find Top Rated Movies'
    end

    it 'has a button to return to the discover page', :vcr do
      click_button('Discover Page')

      expect(current_path).to eq(user_discover_index_path(user1))
    end

    it 'has the title of the movie as a link to the movie details page', :vcr do
      within '.movies' do
        expect(page).to have_css('.title')
      end
    end

    it 'has the vote average of the movie', :vcr do
      within '.movies' do
        expect(page).to have_css('.movie-vote-average')
      end
    end

    it 'has only 20 movies listed', :vcr do
      within '.movies' do
        expect(page).to have_css('.title', count: 20)
      end
    end
  end

  describe 'movie search results page' do
let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com', password: 'test') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com', password: 'test') }

    describe 'happy path' do
      before(:each) do
        visit user_discover_index_path(user1)
        fill_in('Search:', with: 'Fight Club')
        click_button('Find Movies')
      end

      it 'has a button to return to the discover page', :vcr do
        click_button('Discover Page')

        expect(current_path).to eq(user_discover_index_path(user1))
      end

      it 'has the title of the movie as a link to the movie details page', :vcr do
        within '.movies' do
          expect(page).to have_css('.title')
        end
      end

      it 'has the vote average of the movie', :vcr do
        within '.movies' do
          expect(page).to have_css('.movie-vote-average')
        end
      end

      it 'has only 20 movies listed', :vcr do
        within '.movies' do
          expect(page).to have_css('.title', count: 20)
        end
      end
    end

    describe 'edge cases' do
      before(:each) do
        visit user_discover_index_path(user1)
        fill_in('Search:', with: 'Batman')
        click_button('Find Movies')
      end

      it 'has only 20 movies listed', :vcr do
        within '.movies' do
          expect(page).to have_css('.title', count: 20)
        end
      end
    end
  end
end
