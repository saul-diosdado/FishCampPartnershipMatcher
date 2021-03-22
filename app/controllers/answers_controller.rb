# frozen_string_literal: true

# Allows users to answer all questions in a question form.
class AnswersController < ApplicationController
  $user_id = 1

  def index
    @form_id = params[:form_id]
    @questions = Question.where(preference_form_id: @form_id).order('id ASC')
    @answers = Answer.where(user_id: $user_id)
  end

  def new
    @answer = Answer.new(user_id: $user_id, question_id: params[:question_id],
                         preference_form_id: params[:form_id], answer_type: params[:question_type])
    @question = Question.find(params[:question_id])
  end

  def create
    @answer = Answer.new(answers_params)
    if @answer.save
      flash[:notice] = 'Response Saved'
      redirect_to(answers_path(user_id: $user_id, form_id: @answer.preference_form_id))
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
      redirect_to(answers_path(user_id: $user_id, form_id: @answer.preference_form_id))
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
    flash[:notice] = 'Response Deleted' if @answer.destroy
    redirect_to(answers_path(user_id: $user_id, form_id: @answer.preference_form_id))
  end

  private

  def answers_params
    params.require(:answer).permit(:user_id, :question_id, :preference_form_id, :answer_type, :short_answer,
                                   :true_false, :numeric, :multiple_choice)
  end
end
