# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logging in' do
  context 'happy path' do
    it 'can register with valid credentials' do
      name      = 'Valid User'
      email     = 'validuser@validity.com'
      password  = 'test'

      visit register_path
      fill_in :user_name, with: name
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password

      click_on 'Create New User'

      expect(current_path).to eq(user_path(User.last))
      expect(User.last.name).to eq(name)
      expect(User.last.email).to eq(email)
    end
  end

  context 'sad path' do
    it 'cannot register with missing credentials' do
      name      = 'Valid User'
      email     = 'validuser@validity.com'
      password  = ''

      visit register_path
      fill_in :user_name, with: name
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password

      click_on 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password can't be blank")
      expect(User.last.name).to_not eq(name)
      expect(User.last.email).to_not eq(email)
    end

    it 'cannot register with mismatched password' do
      name                    = 'Valid User'
      email                   = 'validuser@validity.com'
      password                = 'test'
      password_confirmation   = 'test1'

      visit register_path
      fill_in :user_name, with: name
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password_confirmation

      click_on 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match")
      expect(User.last.name).to_not eq(name)
      expect(User.last.email).to_not eq(email)
    end

    it 'cannot register without name' do
      name                    = ''
      email                   = 'validuser@validity.com'
      password                = 'test'

      visit register_path
      fill_in :user_name, with: name
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password

      click_on 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Name can't be blank")
      expect(User.last.name).to_not eq(name)
      expect(User.last.email).to_not eq(email)
    end

    it 'cannot register without an email' do
      name                    = 'Valid User'
      email                   = ''
      password                = 'test'

      visit register_path
      fill_in :user_name, with: name
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password

      click_on 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Email can't be blank")
      expect(User.last.name).to_not eq(name)
      expect(User.last.email).to_not eq(email)
    end
  end
end
