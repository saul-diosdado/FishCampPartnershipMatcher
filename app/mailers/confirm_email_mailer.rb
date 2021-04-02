# frozen_string_literal: true

class ConfirmEmailMailer < ActionMailer::Base
    default from: 'FCPartnershipMatcher@example.com'
    layout 'mailer'
    def registration_confirmation(user)
        @user = user
        mail(to: @user.email, subject: 'Email verification')
    end
end