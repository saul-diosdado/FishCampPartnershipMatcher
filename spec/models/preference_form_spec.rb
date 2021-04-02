
require 'rails_helper'

# PreferenceForm Model Unit Test
RSpec.describe PreferenceForm, type: :model do
  it 'preference form is valid with valid attributes' do
    expect(PreferenceForm.new(creator_id: 1, title: 'test', num_prefs: 2, num_antiprefs: 1, active: TRUE)).to be_valid
  end
end

# Checks that prefernce form can be created, read, and deleted.
RSpec.describe PreferenceForm, type: :model do
  before(:all) do
    @form = PreferenceForm.create(creator_id: 1, title: 'test', num_prefs: 2, num_antiprefs: 1, active: TRUE)
  end

  it 'checks that a form can be created' do
    expect(@form).to be_valid
  end

  it 'checks that a form can be read' do
    expect(PreferenceForm.last).to eq(@form)
  end

  it 'checks that a form can be destroyed' do
    previous_form_count = PreferenceForm.count
    @form.destroy
    expect(PreferenceForm.count).to be < previous_form_count
  end
end

# Acceptance Test User Requirement
RSpec.describe 'User actions', type: :system do
  it 'create, edit, and delete preference form' do
    visit new_profile_path
    click_link "Sign up"
    fill_in "user[email]", with: "g@gmail.com"
    fill_in "Password", with: "12345"
    click_button "Sign up"

     visit preference_forms_path
     click_link "Edit Questions"
    # fill_in 'preference_form_title', with: 'test form'
    # click_button "Add Question"

    click_link 'Create New Question'
    fill_in 'question[question]', with: 'q1'
    click_button 'Submit'

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
    click_button 'Submit'
    click_link 'Done'
    expect(page).to have_content('test form 2')

    click_link 'Delete'
    click_button 'Delete Form'
    expect(page).to have_no_content('test form 2')
  end
end
