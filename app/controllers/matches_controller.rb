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
      redirect_to(matches_path({:flash => {:success => "Match created successfully."}}))
    else
      render("new")
    end
  end

  def edit
    @match = Match.find(params[:user_id])
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
  