# frozen_string_literal: true

# General helper functions that can be used throughout the app.
module ApplicationHelper
  def error_messages_for(object)
    render(partial: 'application/error_messages', locals: { object: object })
  end

  def get_partial(question)
    case question.question_type
    when 'True/False'
      'true_false'
    when 'Numeric'
      'numeric'
    when 'Multiple Choice'
      'multiple_choice'
    else
      'short_answer'
    end
  end
end
