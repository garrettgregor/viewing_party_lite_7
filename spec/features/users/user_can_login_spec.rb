# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logging in' do
  let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com', password: 'test') }
  # As a registered user
  # When I visit the landing page `/`
  # I see a link for "Log In"
  # When I click on "Log In"
  # I'm taken to a Log In page ('/login') where I can input my unique email and password.
  # When I enter my unique email and correct password
  # I'm taken to my dashboard page
  context 'happy path' do
    it 'can log in with valid credentials' do
      visit root_path

      click_on 'Log In'

      expect(current_path).to eq(login_path)

      fill_in :email, with: user1.email
      fill_in :password, with: user1.password

      click_on 'Log In'

      expect(current_path).to eq(user_path(user1))
    end
  end

  # As a registered user
  # When I visit the landing page `/`
  # And click on the link to go to my dashboard
  # And fail to fill in my correct credentials
  # I'm taken back to the Log In page
  # And I can see a flash message telling me that I entered incorrect credentials.

  context 'sad path' do
    it 'cannot log in with invalid password' do
      visit login_path

      fill_in :email, with: user1.email
      fill_in :password, with: 'bad password'

      click_on 'Log In'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Sorry, your credentials are invalid')
    end

    it 'cannot log in with invalid email' do
      visit login_path

      fill_in :email, with: 'mcalla1223@gmail.com'
      fill_in :password, with: user1.password

      click_on 'Log In'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Sorry, your credentials are invalid')
    end
  end
end
