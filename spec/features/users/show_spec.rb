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

    UserParty.create!(user_id: user2.id, viewing_party_id: viewing_party_1.id)
    UserParty.create!(user_id: user3.id, viewing_party_id: viewing_party_1.id)
    
    UserParty.create!(user_id: user3.id, viewing_party_id: viewing_party_1.id)

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

    it 'has a section that lists a users hosted viewing parties', :vcr do
      expect(page).to have_css '.viewing-parties'
      
      within '.hosted-parties' do
        image = find("img[src*='https://image.tmdb.org/t/p/original/3bhkrj58Vtu7enYsRolD1fZdja1.jpg']")
        expect(page).to have_content(image)
        expect(page).to have_content('Host: Me')
        expect(page).to have_content('The Godfather')
        expect(page).to have_content('Invitees')
        expect(page).to have_content(user2.name)
        expect(page).to have_content(user3.name)
        expect(page).to_not have_content(user3.name)
      end
    end
    
    it 'has a section fir viewing parties a user was invited to', :vcr do
      visit user_path(user2)
      
      within '.invited-parties' do
        image = find("img[src*='https://image.tmdb.org/t/p/original/3bhkrj58Vtu7enYsRolD1fZdja1.jpg']")
        expect(page).to have_content(image)
        expect(page).to have_content("Host: #{user1.name}")
        expect(page).to have_content('The Godfather')
        expect(page).to have_content('Invitees')
        expect(page).to have_content(user2.name)
        expect(page).to have_content(user3.name)
        expect(page).to_not have_content(user3.name)

        image = find("img[src*='https://image.tmdb.org/t/p/original//hVIKyTK13AvOGv7ICmJjK44DTzp.jpg']")
        expect(page).to have_content(image)
        expect(page).to have_content("Host: #{user1.name}")
        expect(page).to have_content('Some Like it Hot')
        expect(page).to have_content('Invitees')
        expect(page).to have_content("<b>#{user2.name}</b>")
        expect(page).to have_content(user1.name)
        expect(page).to have_content(user3.name)
      end
    end
  end
end
