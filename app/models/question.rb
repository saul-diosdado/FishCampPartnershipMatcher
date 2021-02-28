class Question < ApplicationRecord
    validates_presence_of :question, :question_type

    has_many :choices, dependent: :destroy
    accepts_nested_attributes_for :choices, allow_destroy: true,
        reject_if: :all_blank
end
