# frozen_string_literal: true

module AnswersHelper
    # Renders the preview for question.
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
end
