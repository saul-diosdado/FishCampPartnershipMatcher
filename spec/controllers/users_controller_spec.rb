# frozen_string_literal: true

require 'rails_helper'

#Testing backend of the users controller
RSpec.describe 'UsersController', type: :system do
    describe '#create' do
        it 'creates a user with valid attributes and sends confirmation email' do
            post :create, user: { email: 'a@gmail.com', password: 'password'}

            #expects the mailer to have sent the user an email, and assign the user a correct confirmation token
            expect(controller.current_user).to be_nil
            expect(User.last.email_confirmation_token).to be_present
            expect(ActionMailer::Base.deliveries).not_to be_empty

            email = ActionMailer::Base.deliveries.last
            expect(email).to deliver_to('a@gmail.com')
        end
    end
end

#Testing user pov of users controller
RSpec.describe 'Controller Test', type: :system do
    describe 'Creating a user' do
      it 'expect to receive email upon accoutn creation' do
        visit root_path
        click_link 'Sign up'
        fill_in 'user[email]', with: 'g@gmail.com'
        fill_in 'Password', with: '12345'
        click_button 'Sign up'

        expect(User.last.email_confirmation_token).to be_present
        expect(ActionMailer::Base.deliveries).not_to be_empty

        email = ActionMailer::Base.deliveries.last
        expect(email).to deliver_to('g@gmail.com')
      end
    end
end