# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logging Out' do
  let!(:user1) { User.create!(name: 'Michael', email: 'mcalla123@gmail.com', password: 'test') }
  context 'happy path' do
    it 'can log out' do
      visit root_path

      click_on 'Log In'
      fill_in :email, with: user1.email
      fill_in :password, with: user1.password
      click_on 'Log In'

      visit root_path

      click_on 'Log Out'

      expect(current_path).to eq(root_path)
      expect(page).to have_link('Log In', href: login_path)
    end
  end
end
