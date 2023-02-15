# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New Viewing Party Page' do
  before :each do
    @user = create(:user)
    @movie_id = 14
    @user2 = create(:user, name: 'River', email: 'river@example.com')
    @user3 = create(:user, name: 'Bodi', email: 'bodi@example.com')
    @user4 = create(:user, name: 'Dean', email: 'dean@example.com')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit new_movie_viewing_party_path(@movie_id)
  end

  describe 'page layout' do
    it 'should have a discover page button' do
      visit movies_path

      click_button 'Discover Page'

      expect(current_path).to eq(discover_path)
    end

    it 'displays the movie that user is creating a party for' do
      expect(page).to have_content('Create a Movie Party for American Beauty')
    end
  end

  describe 'New viewing party form - happy path' do
    it 'has a form to create a viewing party' do

      within('.new_viewing_party_form') do
        expect(page).to have_field('Movie Title', with: 'American Beauty', disabled: true)

        fill_in('Duration of Party', with: 180)
        select('2025', from: '[date(1i)]')
        select('March', from: '[date(2i)]')
        select('5', from: '[date(3i)]')
        select('20', from: '[start_time(4i)]')
        select('00', from: '[start_time(5i)]')
        page.check(@user2.display_name)
        page.check(@user3.display_name)
        click_button 'Create Party'
      end

      expect(current_path).to eq dashboard_path
    end
  end

  describe 'New viewing party form - sad path' do
    it 'should not create a new viewing party if the form is not completely filled out' do

      within('.new_viewing_party_form') do
        expect(page).to have_field('Movie Title', with: 'American Beauty', disabled: true)

        fill_in('Duration of Party', with: 10)
        select('2025', from: '[date(1i)]')
        select('March', from: '[date(2i)]')
        select('5', from: '[date(3i)]')
        select('20', from: '[start_time(4i)]')
        select('00', from: '[start_time(5i)]')
        page.check(@user2.display_name)
        page.check(@user3.display_name)
        click_button 'Create Party'
      end

      expect(current_path).to eq(new_movie_viewing_party_path(@movie_id))
      expect(page).to have_content('Viewing Party duration must be greater than or equal to movie runtime which is 122')

      within('.new_viewing_party_form') do
        expect(page).to have_field('Movie Title', with: 'American Beauty', disabled: true)

        fill_in('Duration of Party', with: '')
        select('2025', from: '[date(1i)]')
        select('March', from: '[date(2i)]')
        select('5', from: '[date(3i)]')
        select('20', from: '[start_time(4i)]')
        select('00', from: '[start_time(5i)]')
        page.check(@user2.display_name)
        page.check(@user3.display_name)
        click_button 'Create Party'
      end

      expect(current_path).to eq(new_movie_viewing_party_path(@movie_id))
      expect(page).to have_content('Viewing Party duration must be greater than or equal to movie runtime which is 122')
    end
  end
end
