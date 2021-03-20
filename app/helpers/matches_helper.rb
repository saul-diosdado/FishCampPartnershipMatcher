module MatchesHelper

  # For a given user, populate their Match table entry.
  def generate_prospects(user_id)
    selector_match = Match.where(user_id: user_id).first
    user_prefs = Preference.where(selector_id: user_id)
    prefed_user = Preference.where(selected_id: user_id)
    
    prospects_ids = Array.new
    prospects_avgs = Array.new
    
    # First, get all of the people that I preffed and they preffed me.
    prefed_user.each() do |pref|
      mutual = user_prefs.where(selected_id: pref.selector_id).first
      prospect_added = false
      if mutual != nil
        # These two chairs both prefed each other.
        if pref.pref_type.eql?('Preference') && mutual.pref_type.eql?('Preference')
          avg = mutual.rating + pref.rating / 2
          prospects_avgs.push(avg)
          prospects_ids.push(pref.selector_id)
          prospect_added = true
        end
      else
        # Same as averaged with zero and weighted down to be below 1.
        if pref.pref_type.eql?('Preference')
          prospects_avgs.push(pref.rating / 10)
          prospects_ids.push(pref.selector_id)
          prospect_added = true
        end
      end

      i = prospect_avgs.size() - 1
      while i > 1 && prospect_added
        if prospects_avgs[i] > prospects_avgs[i - 1]
          # Parallel swap.
          prospects_avgs[i], prospects_avgs[i - 1] = prosects_avgs[i - 1], prospects_avgs[i]
          prospects_ids[i], prospects_ids[i - 1] = prospects_ids[i - 1], prospects_ids[i]
        end
        i = i - 1
      end
    end

    # Second, get all of the people I preffed, but they did not pref me.
    user_prefs.each() do |pref|
      mutual = prefed_user.where(selector_id: pref.selected_id, selected_id: pref.selector_id).first
      prospect_added = false
      if mutual == nil
        if pref.pref_type.eql?('Preference')
          prospects_avgs.push(pref.rating / 10)
          prospects_ids.push(pref.selected_id)
        end

        i = prospects_avgs.size() - 1
        while i > 1 && prospect_added
          if prospects_avgs[i] > prospects_avgs[i - 1]
            # Parallel swap.
            prospects_avgs[i], prospects_avgs[i - 1] = prosects_avgs[i - 1], prospects_avgs[i]
            prospects_ids[i], prospects_ids[i - 1] = prospects_ids[i - 1], prospects_ids[i]
          end
          i = i - 1
        end
      end
    end

    # Save the newly generated prospects to the user's match entry.
    selector_match.prospects_ids = prospects_ids
    selector_match.save(validate: false)
  end

  # Didn't have an existing match.
  def create_match(user_id, matched_id)
    # We need to modify the selected Chair's match entry.
    selected_match = Match.where(user_id: matched_id).first

    # Check if the person who we selected already had a partner. Unmatch them if so.
    if selected_match.matched_id != nil
      unmatch_existing_match(matched_id)
    end

    selected_match.matched_id = user_id
    selected_match.save(validate: false)
  end

  # Unmatch
  def unmatch_existing_match(selected_id)
    selected_match = Match.where(user_id: selected_id).first
    selected_match.matched_id = nil
    selected_match.save(validate: false)
  end

end
