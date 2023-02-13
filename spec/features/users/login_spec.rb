require 'rails_helper'

RSpec.describe "User Login page", type: :feature do
  describe 'it allows a user to login ' do
    describe 'happy path' do
      it 'redirects to the user show page with valid field entries' do
        user = create(:user, name: 'River', email: 'river@gmail.com', password: 'mypassword', password_confirmation: 'mypassword')

        visit '/login'

        fill_in('email', with: user.email)
        fill_in('password', with: 'mypassword')

        click_button 'Log In'

        expect(current_path).to eq(user_path(user))
      end
    end

    describe 'sad path' do
      it 'redirects the user back to the login page if username does not exist or password is invalid' do
        user = create(:user, name: 'River', email: 'river@gmail.com', password: 'mypassword', password_confirmation: 'mypassword')

        visit '/login'

        fill_in('email', with: user.email)
        fill_in('password', with: 'wrong')

        click_button 'Log In'

        expect(current_path).to eq '/login'
        expect(page).to have_content 'Email or password invalid'
      end
    end
  end
end
