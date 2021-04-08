class EmailConfirmationGuard < Clearance::SignInGuard
    #when the user tries to sign in, this will be called
    def call
        if unconfirmed?
            failure('You must confirm your email address to sign in.')
        else
            next_guard
        end
    end
    
    #checks that the user's email is confirmed 
    def unconfirmed?
        signed_in? && current_user.email_confirmed_at.present?
    end
  end