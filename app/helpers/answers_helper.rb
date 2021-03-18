module AnswersHelper

    # Renders the preview for question.
    def get_answer_preview(question)
        if @answers.exists?(:question_id => question.id)
            answer = @answers.where(:question_id => question.id).first

            case question.question_type

            # If multiple choice, show selected answer.
            when "Multiple Choice"  
                answer.multiple_choice
            
            # If true false, show either true or false.
            when "True/False"
                answer.true_false ? "True" : "False"

            # If numeric, show selected number.
            when "Numeric"
                answer.numeric

            # If short answer, show response.
            else
                answer.short_answer 
            end
        else
            # If there was no answer given, show "Unanswered"
            "Unanswered"
        end
    end

end
