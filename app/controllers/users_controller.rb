# frozen_string_literal: true

class UsersController < Clearance::UsersController
  # when a user creates an account
  def create
    @user = user_from_params
    # creates confirmation token for user
    @user.email_confirmation_token = Clearance::Token.new

    if @user.save
      # if user is successfully created, delivers a mail to them that will verify their email
      ConfirmEmailMailer.registration_confirmation(@user).deliver_now
      redirect_to(sign_in_path, { flash: { success: 'Please check your email and confirm it to sign in' } })
    else
      redirect_to(sign_up_path, { flash: { danger: 'Account was unable to be created.' } })
    end
  end
end
