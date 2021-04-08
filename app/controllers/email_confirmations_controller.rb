class EmailConfirmationsController < ApplicationController
    #updates the user's email confirmed_at column
    def update
        #finds the user by the confirmation token provided in the email
        user = User.find_by!(email_confirmation_token: params[:token])
        #function updates the user's confirmed_at column to the current time
        user.confirm_email
        sign_in user
        redirect_to root_path, notice: t("flashes.confirmed_email")
    end
end