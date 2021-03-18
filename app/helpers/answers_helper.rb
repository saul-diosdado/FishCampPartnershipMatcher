# frozen_string_literal: true

module AnswersHelper
  def get_answer_preview(question)
    if @answers.exists?(question_id: question.id)
      answer = @answers.where(question_id: question.id).first

      case question.question_type
      when 'Multiple Choice'
        answer.multiple_choice
      when 'True/False'
        answer.true_false ? 'True' : 'False'
      when 'Numeric'
        answer.numeric
      else
        answer.short_answer
      end
    else
      'Unanswered'
    end
  end
end
