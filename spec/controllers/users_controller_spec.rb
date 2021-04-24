# frozen_string_literal: true

require 'rails_helper'

#Testing user pov of users controller
# RSpec.describe 'Controller Test', type: :system do
#     describe 'Creating a user' do
#       it 'expect to receive email upon account creation' do
#         visit root_path
#         click_link 'Sign up'
#         fill_in 'Name', with: 'A name'
#         fill_in 'user[email]', with: 'g@gmail.com'
#         fill_in 'Password', with: '12345'
#         click_button 'Sign up'

#         expect(User.last.email_confirmation_token).to be_present
#         expect(ActionMailer::Base.deliveries).not_to be_empty

#         email = ActionMailer::Base.deliveries.last
#         expect(email).to deliver_to('g@gmail.com')
#       end

#       it 'Must have a name' do
#         visit root_path
#         click_link 'Sign up'
#         fill_in 'user[email]', with: 'g@gmail.com'
#         fill_in 'Password', with: '12345'
#         click_button 'Sign up'
#         expect(page).to have_content('Name can\'t be blank')
#       end

#       it 'Name does not contain first and last name' do
#         visit root_path
#         click_link 'Sign up'
#         fill_in 'Name', with: 'Name'
#         fill_in 'user[email]', with: 'g@gmail.com'
#         fill_in 'Password', with: '12345'
#         click_button 'Sign up'
#         expect(page).to have_content('Name must contain first and last name')
#       end
#     end

#     after(:all) do
#       DatabaseCleaner.clean_with(:truncation)
#     end
# end

RSpec.describe 'Controller', type: :system do
  before(:all) do
    # Preference Form
    @form = PreferenceForm.create(title: 'Test', num_prefs: 2, num_antiprefs: 1, active: true)
    
    # Three Test Users
    @u_1 = User.create(id: 2, email: 'u1@gmail.com', name: 'User 1', approved: true, password: '12345')
    @u_2 = User.create(id: 3, email: 'u2@gmail.com', name: 'User 2', approved: true, password: '12345')
    @u_3 = User.create(id: 4, email: 'u3@gmail.com', name: 'User 3', approved: true, password: '12345')
    @u_4 = User.create(id: 5, email: 'u4@gmail.com', name: 'User 4', approved: true, password: '12345')
    @u_5 = User.create(id: 6, email: 'u5@gmail.com', name: 'User 5', approved: true, password: '12345')
    @p_1 = Profile.create(id: 1, user_id: @u_1.id, name: @u_1.name, email: 'u1@gmail.com', ptanimal: 'The Collaborative Owl', pttruecolors: 'Orange', ptmyersbriggs: 'INTJ', enneagram: 'Achiever')
    @p_2 = Profile.create(id: 2, user_id: @u_2.id, name: @u_2.name, email: 'u2@gmail.com', ptanimal: 'The Avoidant Turtle', pttruecolors: 'Gold', ptmyersbriggs: 'INFP', enneagram: 'Reformer')
    @p_3 = Profile.create(id: 3, user_id: @u_3.id, name: @u_3.name, email: 'u3@gmail.com', ptanimal: 'The Compromising Fox', pttruecolors: 'Green', ptmyersbriggs: 'ENTP', enneagram: 'Investigator')
    @p_4 = Profile.create(id: 4, user_id: @u_4.id, name: @u_4.name, email: 'u4@gmail.com', ptanimal: 'The Competitive Shark', pttruecolors: 'Blue', ptmyersbriggs: 'ISTJ', enneagram: 'Achiever')
    @p_5 = Profile.create(id: 5, user_id: @u_5.id, name: @u_5.name, email: 'u5@gmail.com', ptanimal: 'The Accommodating Teddy Bear', pttruecolors: 'Orange', ptmyersbriggs: 'ESTP', enneagram: 'Enthusiast')
    
    @q_1 = Question.create(id:1, preference_form_id: 1, question: 'Is this a quesiton?', question_type: 'Short Answer')
    @q_2 = Question.create(id:2, preference_form_id: 1, question: 'Is this a quesiton 2?', question_type: 'Multiple Choice')
    @a_1 = Answer.create(user_id: @u_1.id, question_id: 1, preference_form_id: 1, answer_type: 'Short Answer', short_answer: 'This is in fact a question.')
    @a_2 = Answer.create(user_id: @u_1.id, question_id: 2, preference_form_id: 1, answer_type: 'Multiple Choice', multiple_choice: 'Possibly.')
    @a_3 = Answer.create(user_id: @u_2.id, question_id: 1, preference_form_id: 1, answer_type: 'Short Answer', short_answer: 'This is in fact a question.')
    @a_4 = Answer.create(user_id: @u_2.id, question_id: 2, preference_form_id: 1, answer_type: 'Multiple Choice', multiple_choice: 'Possibly.')
    @a_5 = Answer.create(user_id: @u_3.id, question_id: 1, preference_form_id: 1, answer_type: 'Short Answer', short_answer: 'This is in fact a question.')
    @a_6 = Answer.create(user_id: @u_3.id, question_id: 2, preference_form_id: 1, answer_type: 'Multiple Choice', multiple_choice: 'Possibly.')
    @a_7 = Answer.create(user_id: @u_4.id, question_id: 1, preference_form_id: 1, answer_type: 'Short Answer', short_answer: 'This is in fact a question.')
    @a_8 = Answer.create(user_id: @u_4.id, question_id: 2, preference_form_id: 1, answer_type: 'Multiple Choice', multiple_choice: 'Possibly.')
    @a_9 = Answer.create(user_id: @u_5.id, question_id: 1, preference_form_id: 1, answer_type: 'Short Answer', short_answer: 'This is in fact a question.')
    @a_10 = Answer.create(user_id: @u_5.id, question_id: 2, preference_form_id: 1, answer_type: 'Multiple Choice', multiple_choice: 'Possibly.')

    # Mock Preferences
    @pref_1 = Preference.create(id: 1, selector_id: @u_1.id, selected_id: @u_2.id, preference_form_id: 1, pref_type: 'Preference', rating: 4)
    @pref_2 = Preference.create(id: 2, selector_id: @u_1.id, selected_id: @u_3.id, preference_form_id: 1, pref_type: 'Preference', rating: 4)
    @pref_3 = Preference.create(id: 3, selector_id: @u_2.id, selected_id: @u_1.id, preference_form_id: 1, pref_type: 'Preference', rating: 5)
    @pref_4 = Preference.create(id: 4, selector_id: @u_2.id, selected_id: @u_3.id, preference_form_id: 1, pref_type: 'Preference', rating: 3)
    @pref_5 = Preference.create(id: 5, selector_id: @u_3.id, selected_id: @u_1.id, preference_form_id: 1, pref_type: 'Preference', rating: 3)
    @pref_6 = Preference.create(id: 6, selector_id: @u_4.id, selected_id: @u_5.id, preference_form_id: 1, pref_type: 'Preference', rating: 3)
  end

  before(:each) do
    # Match Entries
    @match_1 = Match.create(id: 1, user_id: @u_1.id, matched_id: nil)
    @match_2 = Match.create(id: 2, user_id: @u_2.id, matched_id: nil)
    @match_3 = Match.create(id: 3, user_id: @u_3.id, matched_id: nil)
    @match_4 = Match.create(id: 4, user_id: @u_3.id, matched_id: nil)
    @match_5 = Match.create(id: 5, user_id: @u_5.id, matched_id: nil)
  end

  it 'admin wants to reset database (nuke button)' do
    previous_user_count = User.count
    previous_answer_count = Answer.count
    previous_preferences_count = Preference.count
    previous_match_count = Match.count
    previous_profile_count = Profile.count
    
    admin_login()
    visit remove_all_users_path
    
    expect(User.count).to be < previous_user_count
    expect(Answer.count).to be < previous_answer_count
    expect(Preference.count).to be < previous_preferences_count
    expect(Match.count).to be < previous_match_count
    expect(Profile.count).to be < previous_profile_count

    admin = User.where(email: 'fcpartner123@gmail.com')
    expect(admin).to be_present
  end
  
  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end