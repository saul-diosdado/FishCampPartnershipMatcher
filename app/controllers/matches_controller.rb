# frozen_string_literal: true

class MatchesController < ApplicationController
  before_action :require_login, :check_role

  # Get records of both people with a partner (matched) and without a partner.
  def index
    @unmatched_chairs = Match.where(matched_id: nil)
    @matched_chairs = Match.where.not(matched_id: nil)
    @profiles = Profile.all
  end

  # Given two users, gather all of their information to display a card.
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

  # Given a user's match entry, generate a list of prospects and gather all their information.
  def edit
    @match = Match.find(params[:id])

    # An array of ids of all of the potential matches for this Chair.
    @prospects_ids = []
    helpers.generate_prospects(@match.user_id)

    # Display a warning alert if there is not going to be any prospect cards rendered.
    flash.now[:warning] = 'Warning: This chair has no prospects.' if @prospects_ids.length.zero?

    # If this Chair already had a match, put them as first in the prospects.
    unless @match.matched_id.nil?
      match_in_prospects = false
      index = 0

      @prospects_ids.each do |prospect_id|
        # If the match is in the array of prospects, move it up to be the first in the array.
        if @match.matched_id == prospect_id
          @prospects_ids.insert(0, @prospects_ids.delete_at(index))
          match_in_prospects = true
          break
        end
        index += 1
      end

      # In case their match was not in the prospects array (i.e. was found through "Search")
      @prospects_ids.insert(0, @match.matched_id) unless match_in_prospects
    end

    @profiles = Profile.order(:name)
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

  # Given two different users, get all of their information.
  def edit_search
    @match = Match.find(params[:match_id])
    @prospect_id = params[:user_id].to_i

    @profiles = Profile.all
    @questions = Question.all
    @matches = Match.all

    @selector = Profile.where(user_id: @match.user_id).first
    @selector_preferences = Preference.where(selector_id: @match.user_id, pref_type: 'Preference')
    @selector_anti_preferences = Preference.where(selector_id: @match.user_id, pref_type: 'Anti-Preference')
    @selector_answers = Answer.where(user_id: @match.user_id)

    @selected = Profile.where(user_id: @prospect_id)
    @selected_preferences = Preference.where(selector_id: @prospect_id).where(pref_type: 'Preference')
    @selected_anti_preferences = Preference.where(selector_id: @prospect_id).where(pref_type: 'Anti-Preference')
    @selected_answers = Answer.where(user_id: @prospect_id)
  end

  # For a given user, generate a list of prospects that consists of only Chairs with no partner.
  def edit_unmatched
    @match = Match.find(params[:match_id])

    @profiles = Profile.all
    @questions = Question.all
    @matches = Match.all

    # An array containing the ids of all Chairs that have no partner.
    @prospects_ids = Match.where(matched_id: nil).where.not(user_id: @match.user_id).pluck(:user_id)

    # Display a warning alert if there is no unmatched chairs left.
    flash.now[:warning] = 'Warning: All other chairs already have a partner.' if @prospects_ids.length.zero?

    @selector = Profile.where(user_id: @match.user_id).first
    @selector_preferences = Preference.where(selector_id: @match.user_id, pref_type: 'Preference')
    @selector_anti_preferences = Preference.where(selector_id: @match.user_id, pref_type: 'Anti-Preference')
    @selector_answers = Answer.where(user_id: @match.user_id)

    @selected = Profile.where(user_id: @prospects_ids)
    @selected_preferences = Preference.where(selector_id: @prospects_ids).where(pref_type: 'Preference')
    @selected_anti_preferences = Preference.where(selector_id: @prospects_ids).where(pref_type: 'Anti-Preference')
    @selected_answers = Answer.where(user_id: @prospects_ids)
  end

  # Run some helper functions in order to make sure everyone is unmatched and matched accordingly.
  def update
    @match = Match.find(params[:id])

    # Check if this Chair already had an existing match.
    helpers.unmatch_existing_match(@match.user_id, @match.matched_id) unless @match.matched_id.nil?

    if @match.update(match_params)
      helpers.update_selected_match(@match.matched_id, @match.user_id)
      # Once update occurs, this Chair's Match entry will contain their new partner. Update that partner's Match entry.
      redirect_to(matches_path, { flash: { success: 'Match updated successfully.' } })
    else
      render('edit')
    end
  end

  private

  def match_params
    params.require(:match).permit(:id, :user_id, :matched_id, :preference_form_id, :prospects_ids, :prospects_pref_averages)
  end

  # Before accessing this page, insure the user is a Director.
  def check_role
    return if current_user.has_role? :director

    redirect_to(root_path,
                { flash: { danger: 'WARNING: Only Directors have access to the matching pages.' } })
  end
end
