# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Movies Index Page' do
  before :each do
    @user1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
  end

  describe 'navigation' do
    it 'should have a discover page button' do
      visit movies_path

      click_button 'Discover Page'

      expect(current_path).to eq(discover_path)
    end
  end

  describe 'top movies' do
    it 'should display the top 20 rated movies' do
      visit movies_path

      within('.movies') do
        within('section#movie-238') do
          expect(page).to have_link('The Godfather', href: "/movies/238")
          expect(page).to have_content('Vote Average: 8.7')
        end

        expect(page).to have_selector('section', count: 20)
      end
    end
  end

  describe 'search movies' do
    it 'should display the top 20 movies matching users search criteria' do
      visit movies_path(title_search: 'river')

      expect(page).to have_content('Movie results for: river')

      within('.movies') do
        within('section#movie-395834') do
          expect(page).to have_link('Wind River', href: "/movies/395834")
          expect(page).to have_content('Vote Average: 7.4')
        end

        expect(page).to have_selector('section', count: 20)
      end
    end
  end
end
