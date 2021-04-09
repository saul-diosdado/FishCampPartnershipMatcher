# frozen_string_literal: true

require 'rails_helper'

#Testing the confirm_email function
describe User do
    describe '#confirm_email' do
        it 'sets confirmed_email properly' do
            #create user with valid attributes
            user = User.create(email: 'c@gmail.com', email_confirmation_token: 'token', email_confirmed_at: nil)

            user.confirm_email

            #expect function to have updated the email_confirmed_at column
            expect(user.email_confirmed_at).to be_present
        end
    end
end