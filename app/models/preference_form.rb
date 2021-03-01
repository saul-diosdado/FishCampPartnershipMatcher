class PreferenceForm < ApplicationRecord
    has_many :questions, dependent: :destroy
    has_many :preferences, dependent: :destroy
end
