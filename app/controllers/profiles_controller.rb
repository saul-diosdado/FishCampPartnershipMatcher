# frozen_string_literal: true

class ProfilesController < ApplicationController
  # user must be logged in to access any views
  before_action :require_login
  before_action :check_if_approved

  def index
    user_id = current_user.id
    @profiles = Profile.all
    # If user has already created a profile, brings them to a second index
    render('index2') if Profile.find_by user_id: user_id
  end

  def index2; end

  def new
    # ensures user has correct role to create a profile
    redirect_to(profiles_path, { flash: { danger: 'Must be a chair to create a profile.' } }) unless current_user.has_role? :chair
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

      # Save profile name in current user's account
      # current_user.update(name: @profile.name)

      redirect_to(profiles_path, { flash: { success: "Created #{@profile.name} successfully." } })
    else
      render('new')
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      # Save profile name in current user's account
      # current_user.update(name: @profile.name)
      redirect_to(profiles_path, { flash: { success: "Profile #{@profile.name} updated succesfully." } })
    else
      render('edit')
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  private def profile_params
    params.require(:profile).permit(:name, :email, :phonenumber, :snapchat, :instagram, :facebook, :twitter, :ptanimal, :pttruecolors,
                                    :ptmyersbriggs, :enneagram, :aboutme, :approvedchair, :gender, :user_id)
  end
end
