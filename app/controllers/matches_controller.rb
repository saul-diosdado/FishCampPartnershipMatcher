# frozen_string_literal: true

class MatchesController < ApplicationController
  def index
    @unmatched_chairs = Match.where(matched_id: nil)

    @matched_chairs = Match.where.not(matched_id: nil)

    @profiles = Profile.all
  end

  def show
    @match = Match.find(params[:id])

    @profiles = Profile.all
    @questions = Question.all

    @selector = Profile.where(user_id: @match.user_id).first
    @selector_preferences = Preference.where(selector_id: @match.user_id, pref_type: 'Preference')
    @selector_anti_preferences = Preference.where(selector_id: @match.user_id, pref_type: 'Anti-Preference')
    @selector_answers = Answer.where(user_id: @match.user_id)

    @selected = Profile.where(user_id: @match.matched_id).first
    @selected_preferences = Preference.where(selector_id: @match.matched_id, pref_type: 'Preference')
    @selected_anti_preferences = Preference.where(selector_id: @match.matched_id, pref_type: 'Anti-Preference')
    @selected_answers = Answer.where(user_id: @match.matched_id)
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      redirect_to(matches_path({ flash: { success: 'Match created successfully.' } }))
    else
      render('new')
    end
  end

  def edit
    @match = Match.find(params[:id])

    # An array of ids of all of the potential matches for this Chair.
    @prospects_ids = []
    helpers.generate_prospects(@match.user_id)

    # # Don't run the matching algorithm if the Chair already has prospects saved.
    # if !@match.prospects_ids.empty?
    #   @prospects_ids = @match.prospects_ids
    # else
    #   # Run the matching algoritm to generate prospects and then save them to the database.
    #   helpers.generate_prospects(@match.user_id)
    #   @match.prospects_ids = @prospects_ids
    #   @match.save(validate: false)
    # end

    @profiles = Profile.all
    @questions = Question.all
    @matches = Match.all

    @selector = Profile.where(user_id: @match.user_id).first
    @selector_preferences = Preference.where(selector_id: @match.user_id, pref_type: 'Preference')
    @selector_anti_preferences = Preference.where(selector_id: @match.user_id, pref_type: 'Anti-Preference')
    @selector_answers = Answer.where(user_id: @match.user_id)

    @selected = Profile.where(user_id: @prospects_ids)
    @selected_preferences = Preference.where(selector_id: @prospects_ids).where(pref_type: 'Preference')
    @selected_anti_preferences = Preference.where(selector_id: @prospects_ids).where(pref_type: 'Anti-Preference')
    @selected_answers = Answer.where(user_id: @prospects_ids)
  end

  def update
    @match = Match.find(params[:id])

    # Check if this Chair already had an existing match.
    helpers.unmatch_existing_match(@match.user_id, @match.matched_id) unless @match.matched_id == nil

    if @match.update(match_params)
      helpers.update_selected_match(@match.matched_id, @match.user_id)
      # Once update occurs, this Chair's Match entry will contain their new partner. Update that partner's Match entry.
      redirect_to(matches_path(), { flash: { success: 'Match updated successfully.' } })
    else
      render('edit')
    end
  end

  def delete
    @match = Match.find(params[:id])
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    redirect_to(matches_path({ flash: { success: 'Match removed successfully.' } }))
  end

  private

  def match_params
    params.require(:match).permit(:id, :user_id, :matched_id, :preference_form_id, :prospects_ids, :prospects_pref_averages)
  end
end
