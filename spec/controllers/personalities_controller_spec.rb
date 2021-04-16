# frozen_string_literal: true

require 'rails_helper'

# Ensure the matching algorithm is registering their personality type correctly for Myers Briggs
RSpec.describe 'Controller Test', type: :system do
  before(:each) do
    #Creating users
    @u_1 = User.create(id: 1, email: 'u1@gmail.com', name: 'User 1', approved: true)
    @u_2 = User.create(id: 2, email: 'u2@gmail.com', name: 'User 2', approved: true)
    @u_3 = User.create(id: 3, email: 'u3@gmail.com', name: 'User 3', approved: true)
    @u_4 = User.create(id: 4, email: 'u4@gmail.com', name: 'User 4', approved: true)
    @u_5 = User.create(id: 5, email: 'u5@gmail.com', name: 'User 5', approved: true)
    @u_6 = User.create(id: 6, email: 'u6@gmail.com', name: 'User 6', approved: true)
    @u_7 = User.create(id: 7, email: 'u7@gmail.com', name: 'User 7', approved: true)
    @u_8 = User.create(id: 8, email: 'u8@gmail.com', name: 'User 8', approved: true)
    @u_9 = User.create(id: 9, email: 'u9@gmail.com', name: 'User 9', approved: true)
    @u_10 = User.create(id: 10, email: 'u10@gmail.com', name: 'User 10', approved: true)
    @u_11 = User.create(id: 11, email: 'u11@gmail.com', name: 'User 11', approved: true)
    @u_12 = User.create(id: 12, email: 'u12@gmail.com', name: 'User 12', approved: true)
    @u_13 = User.create(id: 13, email: 'u13@gmail.com', name: 'User 13', approved: true)
    @u_14 = User.create(id: 14, email: 'u14@gmail.com', name: 'User 14', approved: true)
    @u_15 = User.create(id: 15, email: 'u15@gmail.com', name: 'User 15', approved: true)
    @u_16 = User.create(id: 16, email: 'u16@gmail.com', name: 'User 16', approved: true)

    #Creating profiles with corresponding PT type
    @p_1 = Profile.create(id: 1, user_id: @u_1.id, name: @u_1.name, email: 'u1@gmail.com', ptmyersbriggs: 'INFP')
    @p_2 = Profile.create(id: 2, user_id: @u_2.id, name: @u_2.name, email: 'u2@gmail.com', ptmyersbriggs: 'ENFP')
    @p_3 = Profile.create(id: 3, user_id: @u_3.id, name: @u_3.name, email: 'u3@gmail.com', ptmyersbriggs: 'INFJ')
    @p_4 = Profile.create(id: 4, user_id: @u_4.id, name: @u_4.name, email: 'u4@gmail.com', ptmyersbriggs: 'ENFJ')
    @p_5 = Profile.create(id: 5, user_id: @u_5.id, name: @u_5.name, email: 'u5@gmail.com', ptmyersbriggs: 'INTJ')
    @p_6 = Profile.create(id: 6, user_id: @u_6.id, name: @u_6.name, email: 'u6@gmail.com', ptmyersbriggs: 'ENTJ')
    @p_7 = Profile.create(id: 7, user_id: @u_7.id, name: @u_7.name, email: 'u7@gmail.com', ptmyersbriggs: 'INTP')
    @p_8 = Profile.create(id: 8, user_id: @u_8.id, name: @u_8.name, email: 'u8@gmail.com', ptmyersbriggs: 'ENTP')
    @p_9 = Profile.create(id: 9, user_id: @u_9.id, name: @u_9.name, email: 'u9@gmail.com', ptmyersbriggs: 'ISFP')
    @p_10 = Profile.create(id: 10, user_id: @u_10.id, name: @u_10.name, email: 'u10@gmail.com', ptmyersbriggs: 'ESFP')
    @p_11 = Profile.create(id: 11, user_id: @u_11.id, name: @u_11.name, email: 'u11@gmail.com', ptmyersbriggs: 'ISTP')
    @p_12 = Profile.create(id: 12, user_id: @u_12.id, name: @u_12.name, email: 'u12@gmail.com', ptmyersbriggs: 'ESTP')
    @p_13 = Profile.create(id: 13, user_id: @u_13.id, name: @u_13.name, email: 'u13@gmail.com', ptmyersbriggs: 'ISFJ')
    @p_14 = Profile.create(id: 14, user_id: @u_14.id, name: @u_14.name, email: 'u14@gmail.com', ptmyersbriggs: 'ESFJ')
    @p_15 = Profile.create(id: 15, user_id: @u_15.id, name: @u_15.name, email: 'u15@gmail.com', ptmyersbriggs: 'ISTJ')
    @p_16 = Profile.create(id: 16, user_id: @u_16.id, name: @u_16.name, email: 'u16@gmail.com', ptmyersbriggs: 'ESTJ')
  end
  describe 'Should give user information about their personality results MB' do
    it 'Show user an ideal match INFP' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'INFP')
      # visit new_profile_path
      # fill_in 'Name', with: 'g'
      # select 'INFP', from: 'profile[ptmyersbriggs]'
      # click_button 'Create Profile'
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 4')
    end
    it 'Show user an ideal match ENFP' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ENFP')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 3')
    end
    it 'Show user an ideal match INFJ' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'INFJ')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 2')
    end
    it 'Show user an ideal match ENFJ' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ENFJ')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 1')
    end
    it 'Show user an ideal match INTJ' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'INTJ')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 2')
    end
    it 'Show user an ideal match ENTJ' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ENTJ')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 1')
    end
    it 'Show user an ideal match INTP' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'INTP')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 6')
    end
    it 'Show user an ideal match ENTP' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ENTP')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 3')
    end
    it 'Show user an ideal match ISFP' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ISFP')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 4')
    end
    it 'Show user an ideal match ESFP' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ESFP')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 15')
    end
    it 'Show user an ideal match ISTP' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ISTP')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 14')
    end
    it 'Show user an ideal match ESTP' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ESTP')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 13')
    end
    it 'Show user an ideal match ISFJ' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ISFJ')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 10')
    end
    it 'Show user an ideal match ESFJ' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ESFJ')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 9')
    end
    it 'Show user an ideal match ISTJ' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ISTJ')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 10')
    end
    it 'Show user an ideal match ESTJ' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptmyersbriggs: 'ESTJ')
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('User 7')
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

# Ensure the matching algorithm is matching personality type correctly for conflict management test
RSpec.describe 'Controller Test', type: :system do
  before(:all) do
    #Creating user accounts to test matching algorithm
    @u_1 = User.create(id: 1, email: 'u1@gmail.com', name: 'User 1', approved: true)
    @u_2 = User.create(id: 2, email: 'u2@gmail.com', name: 'User 2', approved: true)
    @u_3 = User.create(id: 3, email: 'u3@gmail.com', name: 'User 3', approved: true)
    @u_4 = User.create(id: 4, email: 'u4@gmail.com', name: 'User 4', approved: true)
    @u_5 = User.create(id: 5, email: 'u5@gmail.com', name: 'User 5', approved: true)

    #Filling in profiles for personality test results to test matching
    @p_1 = Profile.create(id: 1, user_id: @u_1.id, name: @u_1.name, email: 'u1@gmail.com', ptanimal: 'The Competitive Shark')
    @p_2 = Profile.create(id: 2, user_id: @u_2.id, name: @u_2.name, email: 'u2@gmail.com', ptanimal: 'The Compromising Fox')
    @p_3 = Profile.create(id: 3, user_id: @u_3.id, name: @u_3.name, email: 'u3@gmail.com', ptanimal: 'The Accommodating Teddy Bear')
    @p_4 = Profile.create(id: 4, user_id: @u_4.id, name: @u_4.name, email: 'u4@gmail.com', ptanimal: 'The Collaborative Owl')
    @p_5 = Profile.create(id: 5, user_id: @u_5.id, name: @u_5.name, email: 'u5@gmail.com', ptanimal: 'The Avoidant Turtle')
  end
  describe 'Should give user information about their personality results for Conflict Management' do
    it 'Show user a match for Shark' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptanimal: 'The Competitive Shark')
      visit personalities_path
      click_link 'Conflict Management'
      expect(page).to have_content('User 3')
    end
    it 'Show user a match for Fox' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptanimal: 'The Compromising Fox')
      visit personalities_path
      click_link 'Conflict Management'
      expect(page).to have_content('User 1')
    end
    it 'Show user a match for Teddy Bear' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptanimal: 'The Accommodating Teddy Bear')
      visit personalities_path
      click_link 'Conflict Management'
      expect(page).to have_content('User 1')
    end
    it 'Show user a match for Owl' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptanimal: 'The Collaborative Owl')
      visit personalities_path
      click_link 'Conflict Management'
      expect(page).to have_content('User 5')
    end
    it 'Show user a match for Turtle' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', ptanimal: 'The Avoidant Turtle')
      visit personalities_path
      click_link 'Conflict Management'
      expect(page).to have_content('User 4')
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

# Ensure the matching algorithm is matching users properly for enneagram
RSpec.describe 'Controller Test', type: :system do
  describe 'Should give user matches for their personality results Enneagram' do
    before(:all) do
      #Creating users
      @u_1 = User.create(id: 1, email: 'u1@gmail.com', name: 'User 1', approved: true)
      @u_2 = User.create(id: 2, email: 'u2@gmail.com', name: 'User 2', approved: true)
      @u_3 = User.create(id: 3, email: 'u3@gmail.com', name: 'User 3', approved: true)
      @u_4 = User.create(id: 4, email: 'u4@gmail.com', name: 'User 4', approved: true)
      @u_5 = User.create(id: 5, email: 'u5@gmail.com', name: 'User 5', approved: true)
      @u_6 = User.create(id: 6, email: 'u6@gmail.com', name: 'User 6', approved: true)
      @u_7 = User.create(id: 7, email: 'u7@gmail.com', name: 'User 7', approved: true)
      @u_8 = User.create(id: 8, email: 'u8@gmail.com', name: 'User 8', approved: true)
      @u_9 = User.create(id: 9, email: 'u9@gmail.com', name: 'User 9', approved: true)

      #Creating profiles with corresponding PT type
      @p_1 = Profile.create(id: 1, user_id: @u_1.id, name: @u_1.name, email: 'u1@gmail.com', enneagram: 'Reformer')
      @p_2 = Profile.create(id: 2, user_id: @u_2.id, name: @u_2.name, email: 'u2@gmail.com', enneagram: 'Helper')
      @p_3 = Profile.create(id: 3, user_id: @u_3.id, name: @u_3.name, email: 'u3@gmail.com', enneagram: 'Achiever')
      @p_4 = Profile.create(id: 4, user_id: @u_4.id, name: @u_4.name, email: 'u4@gmail.com', enneagram: 'Individualist')
      @p_5 = Profile.create(id: 5, user_id: @u_5.id, name: @u_5.name, email: 'u5@gmail.com', enneagram: 'Investigator')
      @p_6 = Profile.create(id: 6, user_id: @u_6.id, name: @u_6.name, email: 'u6@gmail.com', enneagram: 'Loyalist')
      @p_7 = Profile.create(id: 7, user_id: @u_7.id, name: @u_7.name, email: 'u7@gmail.com', enneagram: 'Enthusiast')
      @p_8 = Profile.create(id: 8, user_id: @u_8.id, name: @u_8.name, email: 'u8@gmail.com', enneagram: 'Challenger')
      @p_9 = Profile.create(id: 9, user_id: @u_9.id, name: @u_9.name, email: 'u9@gmail.com', enneagram: 'Peacemaker')
    end
    it 'Show user a match for type Reformer' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', enneagram: 'Reformer')
      visit personalities_path
      click_link 'Enneagram'
      expect(page).to have_content('User 4')
    end
    it 'Show user a match for type Helper' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', enneagram: 'Helper')
      visit personalities_path
      click_link 'Enneagram'
      expect(page).to have_content('User 4')
    end
    it 'Show user a match for type Achiever' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', enneagram: 'Achiever')
      visit personalities_path
      click_link 'Enneagram'
      expect(page).to have_content('User 6')
    end
    it 'Show user a match for Individualist' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', enneagram: 'Individualist')
      visit personalities_path
      click_link 'Enneagram'
      expect(page).to have_content('User 1')
    end
    it 'Show user a match for type Investigator' do
    user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', enneagram: 'Investigator')
      visit personalities_path
      click_link 'Enneagram'
      expect(page).to have_content('User 7')
    end
    it 'Show user a match for type Loyalist' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', enneagram: 'Loyalist')
      visit personalities_path
      click_link 'Enneagram'
      expect(page).to have_content('User 3')
    end
    it 'Show user a match for type Enthusiast' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', enneagram: 'Enthusiast')
      visit personalities_path
      click_link 'Enneagram'
      expect(page).to have_content('User 5')
    end
    it 'Show user a match for type Challenger' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', enneagram: 'Challenger')
      visit personalities_path
      click_link 'Enneagram'
      expect(page).to have_content('User 2')
    end
    it 'Show user a match for type Peacemaker' do
      user_login()
      #Create a profile
      @p_17 = Profile.create(id: 17, user_id: User.last.id, name: 'User 17', email: 'user@gmail.com', enneagram: 'Peacemaker')
      visit personalities_path
      click_link 'Enneagram'
      expect(page).to have_content('User 3')
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

# Ensure the matching algorithm is registering their personality type correctly for True Colors
RSpec.describe 'Controller Test', type: :system do
  describe 'Should give user information about their personality results True Colors' do
    it 'Show user their own personality type Gold' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'User Name'
      select 'Gold', from: 'profile[pttruecolors]'
      click_button 'Create Profile'
      visit personalities_path
      click_link 'True Colors'
      expect(page).to have_content('Your True Color: Gold')
    end
    it 'Show user their own personality type Blue' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'User Name'
      select 'Blue', from: 'profile[pttruecolors]'
      click_button 'Create Profile'
      visit personalities_path
      click_link 'True Colors'
      expect(page).to have_content('Your True Color: Blue')
    end
    it 'Show user their own personality type Green' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'User Name'
      select 'Green', from: 'profile[pttruecolors]'
      click_button 'Create Profile'
      visit personalities_path
      click_link 'True Colors'
      expect(page).to have_content('Your True Color: Green')
    end
    it 'Show user their own personality type Orange' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'User Name'
      select 'Orange', from: 'profile[pttruecolors]'
      click_button 'Create Profile'
      visit personalities_path
      click_link 'True Colors'
      expect(page).to have_content('Your True Color: Orange')
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

# Integration Testing
RSpec.describe 'Controller Test', type: :system do
  describe 'Should reject user if personlities tests are not filled out' do
    it 'Reject if try to click on Myers Briggs page' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'g'
      select 'The Avoidant Turtle', from: 'profile[ptanimal]'
      select 'Green', from: 'profile[pttruecolors]'
      select 'Reformer', from: 'profile[enneagram]'
      click_button 'Create Profile'
      visit personalities_path
      click_link 'Myers Briggs'
      expect(page).to have_content('Profile must have MB test filled out to view this page.')
    end

    it 'Reject if try to click on Conflict Management page' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'User Name'
      select 'INFP', from: 'profile[ptmyersbriggs]'
      select 'Gold', from: 'profile[pttruecolors]'
      select 'Individualist', from: 'profile[enneagram]'
      click_button 'Create Profile'
      visit personalities_path
      click_link 'Conflict Management'
      expect(page).to have_content('Profile must have result of Conflict Management test filled out to view this page.')
    end

    it 'Reject if try to click on True Colors page' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'User Name'
      select 'ENFJ', from: 'profile[ptmyersbriggs]'
      select 'The Compromising Fox', from: 'profile[ptanimal]'
      select 'Enthusiast', from: 'profile[enneagram]'
      click_button 'Create Profile'
      visit personalities_path
      click_link 'True Colors'
      expect(page).to have_content('Profile must have result of True Colors test filled out to view this page.')
    end

    it 'Reject if try to click on Enneagram page' do
      user_login()
      visit new_profile_path
      fill_in 'Name', with: 'User Name'
      select 'ENTJ', from: 'profile[ptmyersbriggs]'
      select 'Blue', from: 'profile[pttruecolors]'
      select 'The Competitive Shark', from: 'profile[ptanimal]'
      click_button 'Create Profile'
      visit personalities_path
      click_link 'Enneagram'
      expect(page).to have_content('Profile must have result of Enneagram test filled out to view this page.')
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end

# def user_login
#   # Sign up with new account
#   visit root_path
#   click_link 'Sign up'
#   fill_in 'user[email]', with: 'user@gmail.com'
#   fill_in 'Password', with: '12345'
#   click_button 'Sign up'

#   @user = User.last
#   @user.approved = TRUE
#   @user.save

#   # Confirm the email
#   open_email 'user@gmail.com'
#   click_first_link_in_email
# end