# frozen_string_literal: true

require 'rails_helper'

#Testing user pov of users controller
RSpec.describe 'Controller Test', type: :system do
    describe 'Creating a user' do
      it 'expect to receive email upon account creation' do
        visit root_path
        click_link 'Sign up'
        fill_in 'Name', with: 'A name'
        fill_in 'user[email]', with: 'g@gmail.com'
        fill_in 'Password', with: '12345'
        click_button 'Sign up'

        expect(User.last.email_confirmation_token).to be_present
        expect(ActionMailer::Base.deliveries).not_to be_empty

        email = ActionMailer::Base.deliveries.last
        expect(email).to deliver_to('g@gmail.com')
      end

      it 'Must have a name' do
        visit root_path
        click_link 'Sign up'
        fill_in 'user[email]', with: 'g@gmail.com'
        fill_in 'Password', with: '12345'
        click_button 'Sign up'
        expect(page).to have_content('Name can\'t be blank')
      end

      it 'Name does not contain first and last name' do
        visit root_path
        click_link 'Sign up'
        fill_in 'Name', with: 'Name'
        fill_in 'user[email]', with: 'g@gmail.com'
        fill_in 'Password', with: '12345'
        click_button 'Sign up'
        expect(page).to have_content('Name must contain first and last name')
      end
    end
end