# frozen_string_literal: true

require 'rails_helper'

#Integration testing
RSpec.describe 'Controller Test', type: :system do
    describe 'proper messages' do
      it 'should flash correct messages in index2' do
        user_login()
        visit new_profile_path
        fill_in 'Name', with: 'a'
        click_button 'Create Profile'
        expect(page).to have_content('Created a successfully.')
      end
  
      it 'Must have a name' do
        user_login()
        visit new_profile_path
        click_button 'Create Profile'
        expect(page).to have_content('Profile must have a name.')
      end

      it 'Edit a profile with incorrect params' do
        user_login()
        visit new_profile_path
        fill_in 'Name', with: 'Bob'
        click_button 'Create Profile'
        visit edit_profile_path(Profile.last)
        fill_in 'Name', with: ''
        click_button 'Save Changes'
        expect(page).to have_content('Profile did not update successfully.')
      end
    end
end
  
# User Requirements Testing
RSpec.describe 'User Working on profile', type: :system do
    it 'Create a profile' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'Bob'
      click_button 'Create Profile'
      expect(page).to have_content('Bob')
    end

    it 'Create a profile with valid about me' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'Bob'
      fill_in 'profile[aboutme]', with: 'This is all about me.'
      click_button 'Create Profile'

      profile = Profile.last
      expect(profile.aboutme).to eq 'This is all about me.'
    end

    it 'Try to create a profile when not a chair' do
      # Sign up with new account
      visit root_path
      click_link 'Sign up'
      fill_in 'user[email]', with: 'user@gmail.com'
      fill_in 'Password', with: '12345'
      click_button 'Sign up'

      #Make the account not have the role of chair
      @user = User.last
      @user.remove_role :chair

      #Approve user
      @user.approved = TRUE
      @user.save

      # Confirm the email
      open_email 'user@gmail.com'
      click_first_link_in_email

      visit new_profile_path
      expect(page).to have_content('Must be a chair to create a profile.')
    end
  
    it 'Edit a profile' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'Bob'
      click_button 'Create Profile'
      visit edit_profile_path(Profile.last)
      fill_in 'Name', with: 'Joe'
      click_button 'Save Changes'
      expect(page).to have_content('Joe')
    end
  
    it 'Show a profile' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'e'
      click_button 'Create Profile'
      visit profile_path(Profile.last)
      expect(page).to have_content(Profile.last.name)
    end

end
  