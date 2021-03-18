class AnswersController < ApplicationController
  before_action :require_login

  def index
    @form = PreferenceForm.find(params[:form_id])
    @questions = Question.where(:preference_form_id => @form.id).order('id ASC')
    @answers = Answer.where(:user_id => current_user.id)
  end

  def new
    @answer = Answer.new(:user_id => current_user.id, :question_id => params[:question_id], :preference_form_id => params[:form_id], :answer_type => params[:question_type])
    @question = Question.find(params[:question_id])
  end

  def create
    @answer = Answer.new(answers_params)
    if @answer.save
      redirect_to(answers_path(:user_id => current_user.id, :form_id => @answer.preference_form_id), {:flash => {:success => "Response Saved."}})
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
      redirect_to(answers_path(:user_id => current_user.id, :form_id =>@answer.preference_form_id), {:flash => {:success => "Response Updated."}})
    else
      render('new')
    end
  end

  def delete
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      redirect_to(answers_path(:user_id => current_user.id, :form_id => @answer.preference_form_id), {:flash => {:success => "Response Deleted."}})
    end
  end

  private

    def answers_params
      params.require(:answer).permit(:user_id, :question_id, :preference_form_id, :answer_type, :short_answer, :true_false, :numeric, :multiple_choice)
    end
end
