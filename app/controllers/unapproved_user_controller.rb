class UnapprovedUserController < ApplicationController
  #Page that people who are unapproved users will see
  def index
    @user = current_user
    approved = @user.approved
    if approved
      redirect_to(profiles_path)
    end
  end
end
