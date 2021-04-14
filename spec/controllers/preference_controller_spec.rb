require 'rails_helper'

# Integration Testing Controller Flash Notice
RSpec.describe 'Controller Test', type: :system do
    describe 'proper messages' do
      before(:all) do
        @form = PreferenceForm.create(title: 'Test', num_prefs: 1, num_antiprefs: 1, active: true)
        @u1 = User.create(id: 1, email: 'u1@gmail.com', role: 'Chair', approved: TRUE)
        @u2 = User.create(id: 2, email: 'u2@gmail.com', role: 'Chair', approved: TRUE)
        @p1 = Profile.create(id: 1, user_id: @u1.id, name: "User 1")
        @p2 = Profile.create(id: 2, user_id: @u2.id, name: "User 2")
      end
  
      it 'should flash correct message in index' do
        user_login()
  
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
  
        click_link 'Add Anti-Pref'
        select 'User 2', from: 'preference[selected_id]'
        select '1', from: 'preference[rating]'
        fill_in 'preference[why]', with: 'test response 2'
        click_button 'Save'
        expect(page).to have_content('Preference Saved')
      end

      after(:all) do
        DatabaseCleaner.clean_with(:truncation)
      end
    end
  end
  
  # Acceptance Test User Requirement
  RSpec.describe 'User actions', type: :system do
    before(:all) do
      @form = PreferenceForm.create(title: 'Test', num_prefs: 2, num_antiprefs: 1, active: true, deadline:  DateTime.now.next_year(10).to_time)
      Question.create(id:1, preference_form_id: 1, question: 'Is this a quesiton?', question_type: 'Short Answer')
      @u1 = User.create(id: 1, email: 'u1@gmail.com', role: 'Chair', approved: TRUE)
      @u2 = User.create(id: 2, email: 'u2@gmail.com', role: 'Chair', approved: TRUE)
      @p1 = Profile.create(id: 1, user_id: @u1.id, name: "User 1")
      @p2 = Profile.create(id: 2, user_id: @u2.id, name: "User 2")
    end

    it 'create, edit, and delete preferences' do
      user_login()
  
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

    after(:all) do
      DatabaseCleaner.clean_with(:truncation)
    end
  end