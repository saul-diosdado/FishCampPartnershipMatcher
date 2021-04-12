# frozen_string_literal: true

class UnapprovedUserController < ApplicationController
  # Page that people who are unapproved users will see
  def index
    @user = current_user
    approved = @user.approved
    redirect_to(profiles_path) if approved
  end
end
