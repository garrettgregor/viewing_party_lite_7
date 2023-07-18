# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/', type: :feature do
  describe 'landing page' do
    let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com', password: 'test') }
    let!(:user2) { User.create!(name: 'Garrett', email: 'garrett123@gmail.com', password: 'test') }

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
      # user = User.create(name: 'testarossa', email: 'testy@testtasker.com', password: 'test')
      click_on 'Log In'
      fill_in :email, with: user1.email
      fill_in :password, with: user1.password
      click_on 'Log In'
      ## Question: why can't I get this to sub in for the above?
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      within '.existing-users' do
        expect(page).to have_content(user1.email.to_s)
        expect(page).to have_content(user2.email.to_s)
      end
    end

    it 'displays a link to go back to the landing page' do
      expect(page).to have_link('Home', href: '/')
    end
  end
end
