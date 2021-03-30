# frozen_string_literal: true

class Answer < ApplicationRecord
    validates_presence_of :user_id, :question_id, :preference_form_id, :answer_type
end
