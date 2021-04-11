# frozen_string_literal: true

require 'rails_helper'

#Testing the email_confirmations controller
RSpec.describe 'Controller Test', type: :system do
    describe 'Ensuring the process of confirming a profile is functioning' do
        it 'with invalid token rejects' do
            # expect do
            #     #visit confirm user page with an invalid token
            #     get :update, token: 'inexistent'
            # end.to raise_exception(ActiveRecord::RecordNotFound)
            visit confirm_email
            expect(page).to raise_exception(ActiveRecord::RecordNotFound)
        end

        it 'with valid token confirms' do
            #Create a user normally
            user = User.create(id: 1, email: 'z@gmail.com', email_confirmation_token: 'valid', email_confirmed_at: nil)

            #visit confirm user page with a valid token
            visit "/confirm_email/{@user.email_confirmation_token}"
            expect(user.email_confirmed_at).to be_present
        end
    end
end