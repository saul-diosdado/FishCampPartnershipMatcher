
require 'rails_helper'

# Acceptance Test User Requirement
RSpec.describe 'User actions', type: :system do
    it 'create, edit, and delete preference form' do
      visit new_profile_path
      click_link "Sign up"
      fill_in "user[email]", with: "g@gmail.com"
      fill_in "Password", with: "12345"
      click_button "Sign up"
  
      visit preference_forms_path
      click_link "Create New Form"
      fill_in 'preference_form_title', with: 'Private Form'
      select 'Private', from: 'preference_form[active]'
      click_button "Add Questions"

      visit preference_forms_path
      click_link "Create New Form"
      fill_in 'preference_form_title', with: 'Public Form'
      select 'Public', from: 'preference_form[active]'
      click_button "Add Questions"
  
      visit public_forms_path
      expect(page).to have_content('Public Form')
      expect(page).to have_no_content('Private Form')
    end
  end