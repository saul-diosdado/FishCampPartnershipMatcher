# frozen_string_literal: true

class PublicFormsController < ApplicationController
  def index
    @forms = PreferenceForm.where(active: true)
  end
end
