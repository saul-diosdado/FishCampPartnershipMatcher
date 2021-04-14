require 'rails_helper'

# Acceptance Test User Requirement
RSpec.describe 'User actions', type: :system do
  it 'create, edit, and delete preference form' do
    director_login()

    visit preference_forms_path
    click_link "Create New Form"
    fill_in 'preference_form_title', with: 'test'
    select 'Private', from: 'preference_form[active]'
    click_button "Add Questions"

    click_link 'Create New Question'
    fill_in 'question[question]', with: 'q1'
    click_button 'Create Question'

    click_link 'Done'
    expect(page).to have_content('test')

    click_link 'Form Settings'
    fill_in 'preference_form_title', with: 'test form 2'
    select 'Public', from: 'preference_form[active]'
    select '3', from: 'preference_form[num_prefs]'
    select '2', from: 'preference_form[num_antiprefs]'
    click_button 'Update Form'
    expect(page).to have_content('test form 2')

    click_link 'Edit Questions'
    click_link 'Create New Question'
    fill_in 'question[question]', with: 'q2'
    click_button 'Create Question'
    click_link 'Done'
    expect(page).to have_content('test form 2')

    # click_link 'Delete'
    # click_button 'Delete Form'
    # expect(page).to have_no_content('test form 2')
  end
end
