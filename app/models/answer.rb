# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates_presence_of :user_id, :question_id, :preference_form_id, :answer_type
end
