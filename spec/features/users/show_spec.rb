# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users/:id', type: :feature do
  describe 'show page' do
    let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com') }

    before(:each) do
      visit user_path(user1)
    end

    it 'displays a users name at the top of the page' do
      expect(page).to have_content("#{user1.name}'s Dashboard")
      expect(page).to_not have_content("#{user2.name}'s Dashboard")
    end
    
    it 'has a css class with a button to discover movies' do
      within '.discover-movies' do
        click_button 'Discover Movies'

        expect(current_path).to eq(user_discover_index_path(user1))
      end
    end
    
    it 'has a css class that lists a users viewing parties' do
      expect(page).to have_css '.viewing-parties'
    end
  end
end