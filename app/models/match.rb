# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :users, optional: true
  belongs_to :preference_form, optional: true
end
