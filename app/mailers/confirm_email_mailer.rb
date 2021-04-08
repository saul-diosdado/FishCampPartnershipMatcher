# frozen_string_literal: true
#sends user a confirmation email when they sign up for an account
class ConfirmEmailMailer < ActionMailer::Base
    default from: 'FCPartnershipMatcher@example.com'
    layout 'mailer'
    def registration_confirmation(user)
        @user = user
        mail(to: @user.email, subject: 'Email verification')
    end
end