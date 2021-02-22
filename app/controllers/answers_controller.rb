class AnswersController < ApplicationController

  $user_id = 1

  def index
    @questions = Question.order('id ASC')
    @answers = Answer.where(:user_id => $user_id)
  end

  def new
    @answer = Answer.new(:user_id => $user_id, :question_id => params[:question_id], :answer_type => params[:answer_type])
    @question = Question.find(params[:question_id])
  end

  def create
    @answer = Answer.new(answers_params)
    if @answer.save
      flash[:notice] = 'Response Saved'
      redirect_to(answers_path)
    else
      render('new')
    end
  end

  def edit
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(answers_params)
      flash[:notice] = 'Response Updated'
      redirect_to(answers_path)
    else
      render('new')
    end
  end

  def delete
    @answer = Answer.find(params[:id])
    @question = params[:question]
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      flash[:notice] = 'Response Deleted'
    end
    redirect_to(answers_path)
  end

  private

    def answers_params
      params.require(:answer).permit(:user_id, :question_id, :answer_type, :short_answer, :true_false, :numeric, :multiple_choice)
    end
end
