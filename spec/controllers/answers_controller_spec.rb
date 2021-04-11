
require 'rails_helper'

# Integration Testing Controller Flash Notice
RSpec.describe 'Controller Test', type: :system do
  describe 'proper messages' do
    it 'should flash correct message in index' do
      user_login()

      visit preference_forms_path
      click_link "Create New Form"
      fill_in 'preference_form_title', with: 'test form'
      select 'Public', from: 'preference_form[active]'
      click_button "Add Question"

      click_link 'Create New Question'
      fill_in 'question[question]', with: 'q1'
      click_button 'Create Question'

      visit public_forms_path
      click_link 'Open'
      click_link 'Add Response'
      fill_in 'answer[short_answer]', with: 'A1'
      click_button 'Save Response'
      expect(page).to have_content('Response Saved.')

      click_link 'Edit'
      fill_in 'answer[short_answer]', with: 'A2'
      click_button 'Save Response'
      expect(page).to have_content('Response Updated.')

      click_link 'Delete'
      click_button 'Delete'
      expect(page).to have_content('Response Deleted.')
    end
  end
end
  
# Acceptance Test User Requirement
RSpec.describe 'User actions', type: :system do
  it 'create, edit, and delete answers' do
    user_login()

    visit preference_forms_path
    click_link "Create New Form"
    fill_in 'preference_form_title', with: 'test form'
    select 'Public', from: 'preference_form[active]'
    click_button "Add Question"

    click_link 'Create New Question'
    fill_in 'question[question]', with: 'q1'
    click_button 'Create Question'

    visit public_forms_path
    click_link 'Open'
    click_link 'Add Response'
    fill_in 'answer[short_answer]', with: 'A1'
    click_button 'Save Response'
    expect(page).to have_content('A1')

    click_link 'Edit'
    fill_in 'answer[short_answer]', with: 'A2'
    click_button 'Save Response'
    expect(page).to have_content('A2')

    click_link 'Delete'
    click_button 'Delete'
    expect(page).to have_no_content('A2')
  end
end
  
def user_login
  # Sign up with new account
  visit root_path
  click_link 'Sign up'
  fill_in 'user[email]', with: 'user@gmail.com'
  fill_in 'Password', with: '12345'
  click_button 'Sign up'

  # Confirm the email
  open_email 'user@gmail.com'
  click_first_link_in_email
end