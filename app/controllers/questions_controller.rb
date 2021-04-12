# frozen_string_literal: true

# Controller for allowing directors to create questions on a specific preference form.
class QuestionsController < ApplicationController
  before_action :require_login, :check_role

  def index
    @form_id = params[:form_id]
    @questions = Question.where(preference_form_id: @form_id)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @form_id = params[:form_id]
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to(questions_path(form_id: @question.preference_form_id),
                  { flash: { success: 'Question created successfully.' } })
    else
      render('new')
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to(questions_path(form_id: @question.preference_form_id),
                  { flash: { success: 'Question updated successfully.' } })
    else
      render('edit')
    end
  end

  def delete
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    form_id = @question.preference_form_id

    @question.destroy

    redirect_to(questions_path(form_id: form_id), { flash: { success: 'Question removed successfully.' } })
  end

  private

  def question_params
    params.require(:question).permit(:preference_form_id, :question, :question_type,
                                     choices_attributes: %i[id content _destroy])
  end
end
