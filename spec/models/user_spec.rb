# frozen_string_literal: true

require 'rails_helper'

# User Model Unit Test
RSpec.describe User, type: :model do
  before(:all) do
    # Create user with valid attributes
    @user = User.create(id: 1, email: 'c@gmail.com', password: '12345', email_confirmation_token: 'token', email_confirmed_at: nil)
    @user.confirm_email
    
    # Mock Users
    @u_2 = User.create(id: 2, email: 'u2@gmail.com', approved: true)
    @u_3 = User.create(id: 3, email: 'u3@gmail.com', approved: true)
    
    @form = PreferenceForm.create(title: 'Test', num_prefs: 2, num_antiprefs: 1, active: true)
    @q_1 = Question.create(id:1, preference_form_id: 1, question: 'Is this a quesiton?', question_type: 'Short Answer')
    @q_2 = Question.create(id:2, preference_form_id: 1, question: 'Is this a quesiton 2?', question_type: 'Multiple Choice')
    @a_1 = Answer.create(user_id: 1, question_id: 1, preference_form_id: 1, answer_type: 'Short Answer', short_answer: 'This is in fact a question.')
    @a_2 = Answer.create(user_id: 1, question_id: 2, preference_form_id: 1, answer_type: 'Multiple Choice', multiple_choice: 'Possibly.')
    
    @pref_1 = Preference.create(id: 1, selector_id: 1, selected_id: 2, preference_form_id: 1, pref_type: 'Preference', rating: 4)
    @pref_2 = Preference.create(id: 2, selector_id: 1, selected_id: 3, preference_form_id: 1, pref_type: 'Preference', rating: 4)

    @match = Match.create(user_id: 1, matched_id: 2)

    @profile = Profile.create(id: 1, user_id: 1, name: 'User Name', email: 'c@gmail.com')
  end

  it 'is valid with valid attributes' do
    expect(User.new(id: 2, email: 'a@gmail.com', password: '12345', email_confirmation_token: 'token', email_confirmed_at: nil)).to be_valid
  end
  
  it 'when deleted also deletes all preferences, answers, and match entry that the user has' do
    previous_answer_count = Answer.count
    previous_preferences_count = Preference.count
    previous_match_count = Match.count
    previous_profile_count = Profile.count

    @user.destroy

    expect(Answer.count).to be < previous_answer_count
    expect(Preference.count).to be < previous_preferences_count
    expect(Match.count).to be < previous_match_count
    expect(Profile.count).to be < previous_profile_count
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

#Testing the confirm_email function
RSpec.describe 'User Model Test', type: :system do
  describe 'confirm_email' do
    it 'sets confirmed_email properly' do
      #create user with valid attributes
      user = User.create(email: 'c@gmail.com', email_confirmation_token: 'token', email_confirmed_at: nil)

      user.confirm_email

      #expect function to have updated the email_confirmed_at column
      expect(user.email_confirmed_at).to be_present
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end