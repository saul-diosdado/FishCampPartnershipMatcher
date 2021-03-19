# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :require_login

  def index
    user_id = current_user.id
    @profiles = Profile.all
    render('index2') if Profile.find_by user_id: user_id
  end

  def index2; end

  def new
    user_id = current_user.id
    @profile = Profile.new
  end

  def create
    filter = p
    @profile = Profile.new(profile_params)
    if @profile.save
      # Create an entry in the Match table for each user.
      match = Match.new(user_id: profile_params[:user_id])
      match.save(validate: false)
      
      redirect_to(profiles_path, { flash: { green: 'Profile created successfully.' } })
    else
      redirect_to(new_profile_path, { flash: { red: 'Profile must have a name.' } })
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to(profiles_path, { flash: { green: 'Profile updated succesfully.' } })
    else
      redirect_to(edit_profile_path, { flash: { red: 'Profile did not update successfully.' } })
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def delete
    @profile = Profile.find(params[:id])
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to(profiles_path, { flash: { red: 'Profile deleted successfully.' } })
  end

  def loggedout; end

  private def profile_params
    params.require(:profile).permit(:name, :email, :phonenumber, :snapchat, :instagram, :facebook, :twitter,
                                    :ptanimal, :pttruecolors, :ptmyersbriggs, :aboutme, :approvedchair, :gender, :user_id)
  end
end
