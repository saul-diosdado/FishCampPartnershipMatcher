# frozen_string_literal: true

class UnapprovedUserController < ApplicationController
  # Page that people who are unapproved users will see
  def index
    @user = current_user
    approved = @user.approved

    if approved
      redirect_to(profiles_path)
    elsif current_user.has_role? :admin
      @user.update(approved: true)
      redirect_to(root_path)
    end
  end
end
