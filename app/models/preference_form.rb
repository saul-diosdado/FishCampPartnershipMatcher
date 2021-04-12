# frozen_string_literal: true

class PreferenceForm < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :preferences, dependent: :destroy
  has_many :matches, dependent: :destroy
end
