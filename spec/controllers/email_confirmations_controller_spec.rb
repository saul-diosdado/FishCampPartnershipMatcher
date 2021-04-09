# frozen_string_literal: true

require 'rails_helper'

#Testing the email_confirmations controller
describe EmailConfirmationsController do
    describe '#update' do
        it 'with invalid token rejects' do
            expect do
                #visit confirm user page with an invalid token
                get :update, token: 'inexistent'
            end.to raise_exception(ActiveRecord::RecordNotFound)
        end

        it 'with valid token confirms' do
            #Create a user normally
            user = User.create(id: 1, email: 'z@gmail.com', email_confirmation_token: 'valid', email_confirmed_at: nil)

            #visit confirm user page with a valid token
            get :update, token: 'valid'
            user.reload
            expect(user.email_confirmed_at).to be_present
            expect(controller.current_user).to eq(user)
            expect(response).to redirect_to(root_path)
            expect(flash[:notice]).to eq t('flashes.confirmed_email')
        end
    end
end