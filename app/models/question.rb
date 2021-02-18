class Question < ApplicationRecord
    has_many :choices, dependent: :destroy
    accepts_nested_attributes_for :choices, allow_destroy: true,
        reject_if: :all_blank
end
