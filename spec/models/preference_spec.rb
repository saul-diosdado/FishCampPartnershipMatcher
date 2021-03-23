
require 'rails_helper'

# Answer Model Unit Test
RSpec.describe Preference, type: :model do
  # Testing short answer
  it 'short answer is valid with valid attributes' do
    expect(Preference.new(id: 1, selector_id: 1, selected_id: 2, preference_form_id: 1, pref_type: "Preference", why: "Test")).to be_valid
  end

end

# Checks that preference can be created, read, and deleted.
RSpec.describe Preference, type: :model do
  before(:all) do
    @pref = Preference.create(id: 1, selector_id: 1, selected_id: 2, preference_form_id: 1, pref_type: "Preference", why: "Test")
  end

  it 'checks that a preference can be created' do
    expect(@pref).to be_valid
  end

  it 'checks that a preference can be destroyed' do
    previous_pref_count = Preference.count
    @pref.destroy
    expect(Preference.count).to be < previous_pref_count
  end
end

# Integration Testing Controller Flash Notice
RSpec.describe 'Controller Test', type: :system do
  describe 'proper messages' do
    before(:all) do
      @u1 = User.create(id: 1, email: 'u1@gmail.com', role: 'Chair', approved: TRUE)
      @u2 = User.create(id: 2, email: 'u2@gmail.com', role: 'Chair', approved: TRUE)
      @p1 = Profile.create(id: 1, user_id: @u1.id, name: "User 1")
      @p2 = Profile.create(id: 2, user_id: @u2.id, name: "User 2")
    end

    it 'should flash correct message in index' do
      visit new_profile_path
      click_link "Sign up"
      fill_in "user[email]", with: "g@gmail.com"
      fill_in "Password", with: "12345"
      click_button "Sign up"

      visit preference_forms_path
      click_link "Create New Form"
      fill_in 'preference_form_title', with: 'test form'
      select 'Public', from: 'preference_form[active]'
      click_button "Add Question"

      click_link 'Create New Question'
      fill_in 'question[question]', with: 'q1'
      click_button 'Submit'

      visit public_forms_path
      click_link 'Open'
      click_link 'Add Response'
      fill_in 'answer[short_answer]', with: 'A1'
      click_button 'Save Response'
      click_link 'Next Page'

      click_link 'Add Pref'
      select 'User 1', from: 'preference[selected_id]'
      select '5', from: 'preference[rating]'
      fill_in 'preference[why]', with: 'test response'
      click_button 'Save'
      expect(page).to have_content('Preference Saved')

      click_link 'Edit'
      select '4', from: 'preference[rating]'
      click_button 'Save'
      expect(page).to have_content('Preference Updated')

      click_link 'Delete Response'
      click_button 'Delete Preference'
      expect(page).to have_content('Preference Deleted')

      click_link 'Add Anti-Pref'
      select 'User 2', from: 'preference[selected_id]'
      select '1', from: 'preference[rating]'
      fill_in 'preference[why]', with: 'test response 2'
      click_button 'Save'
      expect(page).to have_content('Preference Saved')
    end
  end
end

# Acceptance Test User Requirement
RSpec.describe 'User actions', type: :system do
  it 'create, edit, and delete preferences' do
    visit new_profile_path
    click_link "Sign up"
    fill_in "user[email]", with: "g@gmail.com"
    fill_in "Password", with: "12345"
    click_button "Sign up"

    visit preference_forms_path
    click_link "Create New Form"
    fill_in 'preference_form_title', with: 'test form'
    select 'Public', from: 'preference_form[active]'
    click_button "Add Question"

    click_link 'Create New Question'
    fill_in 'question[question]', with: 'q1'
    click_button 'Submit'

    visit public_forms_path
    click_link 'Open'
    click_link 'Add Response'
    fill_in 'answer[short_answer]', with: 'A1'
    click_button 'Save Response'
    click_link 'Next Page'

    click_link 'Add Pref'
    select 'User 1', from: 'preference[selected_id]'
    select '5', from: 'preference[rating]'
    fill_in 'preference[why]', with: 'test response'
    click_button 'Save'
    expect(page).to have_content('User 1')

    click_link 'Delete Response'
    click_button 'Delete Preference'
    expect(page).to have_no_content('User 1')

    click_link 'Add Anti-Pref'
    select 'User 2', from: 'preference[selected_id]'
    select '1', from: 'preference[rating]'
    fill_in 'preference[why]', with: 'test response 2'
    click_button 'Save'
    expect(page).to have_content('User 2')
  end
end