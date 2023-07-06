# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users/:user_id/movies', type: :feature do
  describe 'top movies results page' do
    let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com') }

    before(:each) do
      visit "/users/#{user1.id}/movies?q=top%20rated"
    end

    xit 'has a button to return to the discover page' do
      click_button('Discover Page')

      expect(current_path).to eq(user_discover_index_path(user1))
    end

    xit 'has the title of the movie as a link to the movie details page' do

    end

    xit 'has the vote average of the movie' do

    end

    xit 'has only 20 movies listed' do

    end
  end

  describe 'movie search results page' do
    let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com') }

    describe 'happy path' do
      before(:each) do
        visit "/users/#{user1.id}/movies?q=fight%club"
      end

      xit 'has a button to return to the discover page' do
        click_button('Discover Page')

        expect(current_path).to eq(user_discover_index_path(user1))
      end

      xit 'has the title of the movie as a link to the movie details page' do

      end

      xit 'has the vote average of the movie' do

      end

      xit 'has only 20 movies listed' do

      end
    end

    describe 'edge cases' do
      before(:each) do
        visit "/users/#{user1.id}/movies?q=batman"
      end

      xit 'has only 20 movies listed' do

      end
    end
  end
end
