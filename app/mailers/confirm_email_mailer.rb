# frozen_string_literal: true
#sends user a confirmation email when they sign up for an account
class ConfirmEmailMailer < ActionMailer::Base
    layout 'mailer'
    def registration_confirmation(user)
        @user = user
        #Sends user mail containing a link to confirm their email
        mail(to: @user.email, subject: 'Email verification')
    end
end