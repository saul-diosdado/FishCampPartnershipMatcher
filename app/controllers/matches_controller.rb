class MatchesController < ApplicationController

  def index
    # TDOO: Figure out some way in which everytime a new user is added to the Users table
    # a new entry in Matches table is also created with matcher_id = user_id
    
    # All of the chairs that have not been matched with another chair.
    @unmatched_chairs = Match.all.where(matched_id: nil)

    # Used to display all of the confirmed matches at the bottom of the page.
    @matches = Match.all
  end

  def show
    @match = Match.find(params[:id])
  end

  def new
    @match = Match.new

    user_prefs = User.join(Preference.all.where(selector_id: user_id))
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      redirect_to(matches_path({:flash => {:success => "Match created successfully."}}))
    else
      render("new")
    end
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if @match.update(match_params)
      redirect_to(mathces_path({:flash => {:success => "Match updated successfully."}}))
    else
      render("edit")
    end
  end

  def delete
    @match = Match.find(params[:id])  
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    redirect_to(matches_path({:flash => {:success => "Match removed successfully."}}))
  end

  private

  def match_params
    params.require(:match).permit(:user_id, :matched_id, :preference_form_id, :prospects_ids, :prospects_pref_averages)
  end
end
  