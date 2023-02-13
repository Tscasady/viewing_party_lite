# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Registration Page', type: :feature do
  before :each do
    visit '/register'
  end

  describe 'user registration form - happy path' do
    it 'displays a form to fill in users name, unique email, and password, redirects to user dashdoard page' do
      fill_in('Name', with: 'River')
      fill_in('Email', with: 'river@gmail.com')
      fill_in('Password', with: 'password123')
      fill_in('user_password_confirm', with: 'password123')

      click_button 'Create New User'

      user = User.last
      expect(current_path).to eq(user_path(user))
      expect(User.last.name).to eq('River')
    end
  end

  describe 'user registration form - sad path' do
    it 'can only create a user if all form fields are filled out' do
      fill_in('Name', with: '')
      fill_in('Email', with: '')
      fill_in('Password', with: 'password123')
      fill_in('user_password_confirm', with: 'password123')

      click_button 'Create New User'

      expect(current_path).to eq('/register')
      expect(page).to have_content('User was not created')
      expect(User.count).to eq(0)
    end

    it 'can only create a user if password is filled out' do
      fill_in('Name', with: 'TestUser')
      fill_in('Email', with: 'email@email.com')
      fill_in('Password', with: '')
      fill_in('user_password_confirm', with: '')

      click_button 'Create New User'

      expect(current_path).to eq('/register')
      expect(page).to have_content('User was not created')
      expect(User.count).to eq(0)
    end

    it 'can only create a new user when the email is unique' do
      create(:user, name: 'River', email: 'river@gmail.com')

      fill_in('Name', with: 'Moose')
      fill_in('Email', with: 'river@gmail.com')
      fill_in('Password', with: 'password123')
      fill_in('user_password_confirm', with: 'password123')

      click_button 'Create New User'

      expect(current_path).to eq('/register')
      expect(page).to have_content('User was not created')
      expect(User.count).to eq(1)
    end

    it 'can only create a user with password and password_confirm fields matching' do
      fill_in('Name', with: 'Moose')
      fill_in('Email', with: 'river@gmail.com')
      fill_in('Password', with: 'password123')
      fill_in('user_password_confirm', with: 'NotConfirmed')

      click_button 'Create New User'

      expect(current_path).to eq('/register')
      expect(page).to have_content('User was not created. Password should match confirmed password.')
      expect(User.count).to eq(0)
    end
  end
end
