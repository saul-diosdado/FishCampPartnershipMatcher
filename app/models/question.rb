# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :delete_all
  has_many :choices, dependent: :delete_all
  validates_presence_of :question, :question_type
  accepts_nested_attributes_for :choices, allow_destroy: true,
                                          reject_if: :all_blank
end
