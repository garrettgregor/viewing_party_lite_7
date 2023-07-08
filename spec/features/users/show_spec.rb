# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users/:id', type: :feature do
  describe 'show page' do
    let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com') }
    let!(:user3) { User.create!(name: 'Shannon', email: 'shannon123@gmail.com') }

    let!(:viewing_party_1) { ViewingParty.create!(
      duration: 175,
      start_date: 'Wed, 07 Aug 2024',
      start_time: 'Sat, 01 Jan 2000 19:00:00.000000000 UTC +00:00',
      movie_id: 238,
      host_id: user1.id
    ) }

    let!(:viewing_party_2) { 
      ViewingParty.create!(
        duration: 122,
        start_date: 'Wed, 08 Aug 2024',
        start_time: 'Sat, 01 Jan 2000 19:00:00.000000000 UTC +00:00',
        movie_id: 239,
        host_id: user1.id
      )
    }

    before(:each) do
      visit user_path(user1)
    end

    it 'displays a users name at the top of the page', :vcr do
      expect(page).to have_content("#{user1.name}'s Dashboard")
      expect(page).to_not have_content("#{user2.name}'s Dashboard")
    end

    it 'has a css class with a button to discover movies', :vcr do
      within '.discover-movies' do
        click_button 'Discover Movies'

        expect(current_path).to eq(user_discover_index_path(user1))
      end
    end

    it 'has a css class that lists a users viewing parties', :vcr do
      expect(page).to have_css '.viewing-parties'
    end
  end
end
