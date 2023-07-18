# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users/:id/movies/viewing_party/new', type: :feature do
  describe 'create new viewing party' do
    let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com', password: 'test') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com', password: 'test') }
    let!(:user3) { User.create!(name: 'Shannon', email: 'shannon123@gmail.com', password: 'test') }

    before(:each) do
      visit new_user_movie_viewing_party_path(user1, 238)
    end

    ## This is causing an error with VCR
    # it 'has a button to return to the discover page', :vcr do
    #   click_button('Discover Page')

    #   expect(current_path).to eq(user_discover_index_path(user1))
    # end

    it 'has the name of the movie', :vcr do
      viewing_party_title = 'Create a Movie Party for The Godfather'
      expect(page).to have_content(viewing_party_title)
      expect(viewing_party_title).to appear_before('Viewing Party Details')
    end

    it 'has a form to create viewing party', :vcr do
      within '.viewing-party-form' do
        expect(page).to have_field(:duration, with: 175)
        fill_in(:start_date, with: '07/08/2024')
        fill_in(:start_time, with: '07:00 PM')
        find(:css, "#user_ids_[value=#{user2.id}]").set(true)
        find(:css, "#user_ids_[value=#{user3.id}]").set(true)
        click_on('Create Party')
        expect(current_path).to eq(user_path(user1))
      end
    end
  end
end
