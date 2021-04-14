# frozen_string_literal: true

class PreferenceForm < ApplicationRecord
  has_many :questions, dependent: :delete_all
  has_many :preferences, dependent: :delete_all
  has_many :matches, dependent: :delete_all
end
