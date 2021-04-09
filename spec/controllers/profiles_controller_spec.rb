# frozen_string_literal: true

require 'rails_helper'

#Integration testing
RSpec.describe 'Controller Test', type: :system do
    describe 'proper messages' do
      it 'should flash correct messages in index2' do
        # visit new_profile_path
        # click_link 'Sign up'
        # fill_in 'user[email]', with: 'a@gmail.com'
        # fill_in 'Password', with: '12345'
        # click_button 'Sign up'
        #sign_in
        user = User.create(email: 'a@gmail.com', password: '12345')
        visit new_profile_path(as: user)
        fill_in 'Name', with: 'a'
        click_button 'Create Profile'
        expect(page).to have_content('Created a successfully.')
      end
  
      it 'Must have a name' do
        user = User.create(email: 'a@gmail.com', password: '12345')
        visit new_profile_path(as: user)
        click_button 'Create Profile'
        expect(page).to have_content('Profile must have a name.')
      end
    end
end
  
# User Requirements Testing
RSpec.describe 'User Working on profile', type: :system do
    it 'Create a profile' do
      user = User.create(email: 'a@gmail.com', password: '12345')
      visit new_profile_path(as: user)
      fill_in 'Name', with: 'Bob'
      click_button 'Create Profile'
      expect(page).to have_content('Bob')
    end
  
    it 'Edit a profile' do
      user = User.create(email: 'a@gmail.com', password: '12345')
      sign_in_as(user)
      visit new_profile_path
      fill_in 'Name', with: 'Bob'
      click_button 'Create Profile'
      visit edit_profile_path(Profile.last)
      fill_in 'Name', with: 'Joe'
      click_button 'Save Changes'
      expect(page).to have_content('Joe')
    end
  
    it 'Show a profile' do
      user = User.create(email: 'a@gmail.com', password: '12345')
      sign_in_as(user)
      visit new_profile_path
      fill_in 'Name', with: 'e'
      click_button 'Create Profile'
      visit profile_path(Profile.last)
      expect(page).to have_content(Profile.last.name)
    end
  
    it 'Delete a profile' do
      user = User.create(email: 'a@gmail.com', password: '12345')
      sign_in_as(user)
      visit new_profile_path
      fill_in 'Name', with: 'f'
      click_button 'Create Profile'
      visit delete_profile_path(Profile.last)
      click_button 'Delete Profile'
      expect(page).to have_content('Profile deleted successfully.')
    end
end
  