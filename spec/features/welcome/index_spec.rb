# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'The landing page index', type: :feature do
  describe 'landing page index' do
    before :each do
      @user1 = create(:user)
      create_list(:user, 5)
    end
    it 'displays the application title' do
      visit root_path
      expect(page).to have_content('Viewing Party')
    end

    it 'displays a home link to go back to the landing page' do
      visit root_path

      expect(page).to have_link('Home')

      click_on 'Home'

      expect(current_path).to eq('/')
    end

    describe 'user logged in' do
      it 'displays existing users' do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit root_path

        within('.users') do
          within("section#user-#{@user1.id}") do
            expect(page).to have_content(@user1.email)
          end
          expect(page).to have_selector('section', count: 7)
        end
      end
    end

    describe 'user not logged in' do
      it 'displays a button to create a new user' do
        visit root_path
        expect(page).to have_button('Create a New User')

        click_button 'Create a New User'

        expect(current_path).to eq(register_path)
      end

      it 'has a log in link' do
        visit root_path
        expect(page).to have_link('Login')
      end
    end

  end
end
