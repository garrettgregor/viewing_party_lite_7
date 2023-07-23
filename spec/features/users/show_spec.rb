# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users/:id', type: :feature do
  describe 'show page' do
    let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com', password: 'test') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com', password: 'test') }
    let!(:user3) { User.create!(name: 'Shannon', email: 'shannon123@gmail.com', password: 'test') }

    let!(:viewing_party_1) do
      ViewingParty.create!(
        duration: 175,
        start_date: 'Wed, 07 Aug 2024',
        start_time: 'Sat, 01 Jan 2000 19:00:00.000000000 UTC +00:00',
        movie_id: 238,
        host_id: user1.id
      )
    end

    let!(:viewing_party_2) do
      ViewingParty.create!(
        duration: 122,
        start_date: 'Wed, 08 Aug 2024',
        start_time: 'Sat, 01 Jan 2000 19:00:00.000000000 UTC +00:00',
        movie_id: 239,
        host_id: user1.id
      )
    end

    let!(:party_1) { UserParty.create!(user_id: user2.id, viewing_party_id: viewing_party_1.id) }

    let!(:party_2) { UserParty.create!(user_id: user3.id, viewing_party_id: viewing_party_2.id) }

    before(:each) do
      visit root_path

      click_on 'Log In'
      fill_in :email, with: user1.email
      fill_in :password, with: user1.password
      click_on 'Log In'
    end

    it 'displays a users name at the top of the page', :vcr do
      visit user_path(user1)

      expect(page).to have_content("#{user1.name}'s Dashboard")
      expect(page).to_not have_content("#{user2.name}'s Dashboard")
    end

    it 'has a css class with a button to discover movies', :vcr do
      visit user_path(user1)

      within '.discover-movies' do
        click_button 'Discover Movies'

        expect(current_path).to eq(user_discover_index_path(user1))
      end
    end

    it 'has a section that lists a users hosted viewing parties', :vcr do
      visit user_path(user1)

      expect(page).to have_css '.viewing-parties'

      within "#hosted-party-#{viewing_party_1.id}" do
        ## Question: is there a better way to know if specific image is coming through?
        # image = page.find("img[src='https://image.tmdb.org/t/p/original/3bhkrj58Vtu7enYsRolD1fZdja1.jpg']")
        # ^ doesn't work
        expect(page).to have_css('.poster')
        expect(page).to have_content('Host: Me')
        expect(page).to have_content('The Godfather')
        expect(page).to have_content('Invitees')
        expect(page).to have_content(user2.name)
        expect(page).to_not have_content(user3.name)
        expect(page).to_not have_content(user1.name)
      end
    end

    it 'has a section for viewing parties a user was invited to', :vcr do
      visit root_path

      click_on 'Log Out'
      click_on 'Log In'
      fill_in :email, with: user2.email
      fill_in :password, with: user2.password
      click_on 'Log In'

      visit user_path(user2)

      within "#invited-party-#{viewing_party_1.id}" do
        expect(page).to have_css('.poster')
        expect(page).to have_content("Host: #{user1.name}")
        expect(page).to have_content('The Godfather')
        expect(page).to have_content('Invitees')
        expect(page).to_not have_content(user3.name)
        expect(page).to have_css('.self-invited')
        ## Question: how can we check if certain text is bolded?
        # expect(page).to have_content("<strong>#{user2.name}</strong>")
        # ^ can't find way to specify bold text
        expect(page).to have_content(user2.name)
      end

      visit root_path

      click_on 'Log Out'
      click_on 'Log In'
      fill_in :email, with: user3.email
      fill_in :password, with: user3.password
      click_on 'Log In'

      visit user_path(user3)

      within "#invited-party-#{viewing_party_2.id}" do
        expect(page).to have_css('.poster')
        expect(page).to have_content("Host: #{user1.name}")
        expect(page).to have_content('Some Like It Hot')
        expect(page).to have_content('Invitees')
        expect(page).to_not have_content(user2.name)
        expect(page).to have_css('.self-invited')
      end
    end
  end
end
