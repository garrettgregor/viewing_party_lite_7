# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/', type: :feature do
  describe 'landing page' do
    let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com') }

    before(:each) do
      visit '/'
    end

    it 'displays the application title' do
      expect(page).to have_content('Viewing Party')
    end

    it 'displays a button to create a new user' do
      expect(page).to have_button('Create New User')
      click_button 'Create New User'

      expect(current_path).to eq('/register')
    end

    it 'displays a list of existing users, that links to the users dashboard' do
      within '.existing-users' do
        expect(page).to have_link(user1.email.to_s, href: user_path(user1))
        expect(page).to have_link(user2.email.to_s, href: user_path(user2))
      end
    end

    it 'displays a link to go back to the landing page' do
      expect(page).to have_link('Home', href: '/')
    end
  end
end
