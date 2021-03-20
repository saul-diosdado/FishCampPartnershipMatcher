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

  def get_answer_preview(question)
    if @answers.exists?(:question_id => question.id)
      answer = @answers.where(:question_id => question.id).first

      case question.question_type
      when "Multiple Choice"  # If multiple choice, show selected answer.
        answer.multiple_choice
      when "True/False" # If true false, show either true or false.
        answer.true_false ? "True" : "False"
      when "Numeric"  # If numeric, show selected number.
        answer.numeric
      else  # If short answer, show response.
        answer.short_answer 
      end
    else  # If there was no answer given, show "Unanswered"
      "Unanswered"
    end
  end

  # Given an Answer object, return the corresponding answer based on the original question type.
  def get_answer(answer)
    # In case the Chair did not answer this question.
    if answer == nil
      return "No response provided."
    end

    case answer.answer_type
    when "Multiple Choice"  # If multiple choice, show selected answer.
      answer.multiple_choice
    when "True/False" # If true false, show either true or false.
      answer.true_false ? "True" : "False"
    when "Numeric"  # If numeric, show selected number.
      answer.numeric
    else  # If short answer, show response.
      answer.short_answer 
    end
  end
end
