class QuestionsController < ApplicationController
    def index
        @questions = Question.all
    end

    def show
        @question = Question.find(params[:id])
    end

    def new
        @question = Question.new
    end

    def create
        @question = Question.new(question_params)
        if @question.save
            redirect_to(questions_path, {:flash => {:green => "Question created successfully."}})
        else
            render("new")
        end
    end

    def edit
        @question = Question.find(params[:id])
    end

    def update
        @question = Question.find(params[:id])
        if @question.update(question_params)
            redirect_to(questions_path, {:flash => {:green => "Question updated successfully."}})
        else
            render("edit")
        end
    end

    def delete
        @question = Question.find(params[:id])
    end

    def destroy
        @question = Question.find(params[:id])
        @question.destroy
        redirect_to(questions_path, {:flash => {:red => "Question removed successfully."}})
    end

    private def book_params
        params.require(:question).permit(:text)
    end
end
