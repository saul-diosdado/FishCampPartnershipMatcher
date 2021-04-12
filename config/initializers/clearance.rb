# frozen_string_literal: true

Clearance.configure do |config|
  config.routes = false
  config.mailer_sender = 'FCPartnershipMatcher@example.com'
  config.sign_in_guards = [EmailConfirmationGuard]
end
