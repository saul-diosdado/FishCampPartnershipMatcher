class EmailConfirmationGuard < Clearance::SignInGuard
    def call
        if unconfirmed?
            failure('You must confirm your email address to sign in.')
        else
            next_guard
        end
    end
  
    def unconfirmed?
        signed_in? && current_user.email_confirmed_at.present?
    end
  end