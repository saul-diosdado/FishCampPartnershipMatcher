# frozen_string_literal: true

class PreferencesController < ApplicationController
  before_action :require_login

  def index
    @form = PreferenceForm.find(params[:form_id])
    @profiles = Profile.all
    @users = User.where(role: 'Chair', approved: TRUE).where.not(id: current_user.id)
    @prefs = Preference.where(preference_form_id: @form.id, selector_id: current_user.id,
                              pref_type: 'Preference').order('rating DESC')
    @antiprefs = Preference.where(preference_form_id: @form.id, selector_id: current_user.id,
                                  pref_type: 'Anti-Preference')
  end

  def new
    # Load all approved chairs
    users = User.where(role: 'Chair', approved: TRUE).where.not(id: current_user.id)
    user_ids = users.map { |user| user.id }
    # Load all of the users prefs
    prefs = Preference.where(preference_form_id: params[:form_id], selector_id: current_user.id)
    # User can only pref users who they have not preffed already.
    prospects = user_ids.map { |id| if prefs.where(selected_id: id).exists? == FALSE then id end }

    # Show all potential prefs
    @profiles = Profile.where(user_id: prospects)

    @pref = Preference.new(:preference_form_id => params[:form_id], :selector_id => current_user.id, 
                            :pref_type => params[:pref_type])
  end

  def create
    @pref = Preference.new(preferences_params)
    if @pref.save
      flash[:notice] = 'Preference Saved'
      redirect_to(preferences_path(form_id: @pref.preference_form_id, user_id: @pref.selector_id))
    else
      render('new')
    end
  end

  def edit
    @pref = Preference.find(params[:id])

    # Load all approved chairs
    users = User.where(role: 'Chair', approved: TRUE).where.not(id: current_user.id)
    user_ids = users.map { |user| user.id }
    # Load all of the users prefs
    prefs = Preference.where(preference_form_id: @pref.preference_form_id, selector_id: current_user.id)
    # User can only pref users who they have not preffed already.
    prospects = user_ids.map { |id| if prefs.where(selected_id: id).exists? == FALSE then id end }
    
    @profiles = Profile.where(user_id: (prospects + [@pref.selected_id]))
  end

  def update
    @pref = Preference.find(params[:id])
    if @pref.update(preferences_params)
      flash[:notice] = 'Preference Updated'
      redirect_to(preferences_path(form_id: @pref.preference_form_id, user_id: @pref.selector_id))
    else
      render('new')
    end
  end

  def delete
    @pref = Preference.find(params[:id])
    @profile = Profile.where(user_id: @pref.selected_id).first
  end

  def destroy
    @pref = Preference.find(params[:id])
    form_id = @pref.preference_form_id
    user_id = @pref.selector_id

    flash[:notice] = 'Preference Deleted' if @pref.destroy
    redirect_to(preferences_path(form_id: form_id, user_id: user_id))
  end

  private

  def preferences_params
    params.require(:preference).permit(:preference_form_id, :selector_id, :selected_id, :pref_type, :rating, :why)
  end
end
