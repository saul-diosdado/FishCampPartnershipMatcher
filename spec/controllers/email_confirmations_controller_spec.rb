# frozen_string_literal: true

require 'rails_helper'

#Testing the email_confirmations controller
RSpec.describe 'Controller Test', type: :system do
  describe 'Ensuring the process of confirming a profile is functioning' do
    it 'with valid token confirms' do
        # Sign up with new account
        visit root_path
        click_link 'Sign up'
        fill_in 'user[email]', with: 'user@gmail.com'
        fill_in 'Password', with: '12345'
        click_button 'Sign up'

        # Approve user
        @user = User.last
        @user.approved = TRUE
        @user.save

        # Confirm the email
        open_email 'user@gmail.com'
        click_first_link_in_email

        expect(page).to have_content('Email Confirmed! Welcome to the site')
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end