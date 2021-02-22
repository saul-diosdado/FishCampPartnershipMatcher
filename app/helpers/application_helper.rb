module ApplicationHelper

    def error_messages_for(object)
        render(:partial => "application/error_messages", :locals => {:object => object}) 
    end
     
    def get_partial(question)
        if question.question_type == "True/False"
            "true_false"
        elsif question.question_type == "Numeric"
            "numeric"
        elsif question.question_type == "Multiple Choice"
            "multiple_choice"
        else
            "short_answer"
        end
    end

end
