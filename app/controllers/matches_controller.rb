# frozen_string_literal: true

class MatchesController < ApplicationController
  def index
    @unmatched_chairs = Match.where(matched_id: nil)

    @matched_chairs = Match.where.not(matched_id: nil)

    @info = Profile.all
  end

  def show
    @match = Match.find(params[:id])
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
    @info = Profile.all

    @questions = Question.all

    @selector = Profile.where(user_id: @match.user_id).first
    @selector_preferences = Preference.where(selector_id: @match.user_id, pref_type: 'Preference')
    @selector_anti_preferences = Preference.where(selector_id: @match.user_id, pref_type: 'Anti-Preference')
    @selector_answers = Answer.where(user_id: @match.user_id)

    helpers.generate_prospects(@match.user_id)

    @selected = Profile.where(user_id: @match.prospects_ids)
    @selected_preferences = Preference.where(selector_id: @match.prospects_ids).where(pref_type: 'Preference')
    @selected_anti_preferences = Preference.where(selector_id: @match.prospects_ids).where(pref_type: 'Anti-Preference')
    @selected_answers = Answer.where(user_id: @match.prospects_ids)
  end

  def update
    @match = Match.find(params[:id])

    # Check if this Chair already had an existing match.
    helpers.unmatch_existing_match(@match.matched_id) unless @match.matched_id.nil?

    if @match.update(match_params)
      helpers.create_match(params[:matched_id], params[:user_id])
      redirect_to(matches_path({ flash: { success: 'Match updated successfully.' } }))
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
    params.require(:match).permit(:user_id, :matched_id, :preference_form_id, :prospects_ids, :prospects_pref_averages)
  end
end
