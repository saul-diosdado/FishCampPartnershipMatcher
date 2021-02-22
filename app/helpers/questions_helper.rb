module QuestionsHelper
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
