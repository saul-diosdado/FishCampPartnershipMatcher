# frozen_string_literal: true

module MatchesHelper
  # For a given user, populate their Match table entry.
  def generate_prospects(user_id)
    user_prefs = Preference.where(selector_id: user_id)
    prefed_user = Preference.where(selected_id: user_id)

    prospects_avgs = []

    # First, get all of the people that I preffed and they preffed me.
    prefed_user.each do |pref|
      mutual = user_prefs.where(selected_id: pref.selector_id).first
      prospect_added = false
      if !mutual.nil?
        # These two chairs both prefed each other.
        if pref.pref_type.eql?('Preference') && mutual.pref_type.eql?('Preference')
          avg = mutual.rating + pref.rating / 2
          prospects_avgs.push(avg)
          @prospects_ids.push(pref.selector_id)
          prospect_added = true
        end
      elsif pref.pref_type.eql?('Preference')
        # Same as averaged with zero and weighted down to be below 1.
        prospects_avgs.push(pref.rating / 10)
        @prospects_ids.push(pref.selector_id)
        prospect_added = true
      end

      i = prospects_avgs.size - 1
      while i > 1 && prospect_added
        if prospects_avgs[i] > prospects_avgs[i - 1]
          # Parallel swap.
          prospects_avgs[i - 1] = prospects_avgs[i]
          prospects_avgs[i] = prospects_avgs[i - 1]
          @prospects_ids[i], @prospects_ids[i - 1] = @prospects_ids[i - 1], @prospects_ids[i]
        end
        i -= 1
      end
    end

    # Second, get all of the people I preffed, but they did not pref me.
    user_prefs.each do |pref|
      mutual = prefed_user.where(selector_id: pref.selected_id, selected_id: pref.selector_id).first
      prospect_added = false
      next unless mutual.nil?

      if pref.pref_type.eql?('Preference')
        prospects_avgs.push(pref.rating / 10)
        @prospects_ids.push(pref.selected_id)
      end

      i = prospects_avgs.size - 1
      while i > 1 && prospect_added
        if prospects_avgs[i] > prospects_avgs[i - 1]
          # Parallel swap.
          prospects_avgs[i - 1] = prospects_avgs[i]
          prospects_avgs[i] = prospects_avgs[i - 1]
          @prospects_ids[i], @prospects_ids[i - 1] = @prospects_ids[i - 1], @prospects_ids[i]
        end
        i -= 1
      end
    end
  end

  # When User A selects User B as a match, we need to update User B's Match entry to have A as a partner.
  #
  # @params selected_id User B's ID
  # @params user_id User A's ID
  def update_selected_match(selected_id, user_id)
    # We need to modify the selected Chair's match entry.
    selected_match = Match.where(user_id: selected_id).first

    # Check if the person who we selected already had a partner. Unmatch them if so.
    unmatch_existing_match(selected_id, selected_match.matched_id) unless selected_match.matched_id.nil?

    selected_match.matched_id = user_id
    selected_match.save(validate: false)
  end

  # In the case where we are finding a match for User A and we select User B.
  # However, User B was already matched to User C, therefore we must unmatch User B and C.
  # Also used when User A is already matched to User D, so we unmatch User A and D
  #
  # @params user_match The ID of User A/B
  # @params matched_id The ID of User C/D
  def unmatch_existing_match(user_id, matched_id)
    # Find User C/D's Match entry.
    selected_match = Match.where(user_id: matched_id).first
    selected_match.matched_id = nil
    selected_match.save(validate: false)

    # Find User A/B's Match entry.
    selector_match = Match.where(user_id: user_id).first
    selector_match.matched_id = nil
    selector_match.save(validate: false)
  end
end
