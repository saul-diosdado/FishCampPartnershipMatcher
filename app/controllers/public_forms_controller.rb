# frozen_string_literal: true

class PublicFormsController < ApplicationController
  before_action :require_login

  def index
    @forms = PreferenceForm.where(active: TRUE)
    @answers = Answer.where(user_id: current_user.id)
    @prefs = Preference.where(user_id: current_user.id)
  end
end
