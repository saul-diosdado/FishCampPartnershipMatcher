# frozen_string_literal: true

class PreferenceFormsController < ApplicationController
  before_action :require_login

  def index
    @forms = PreferenceForm.all
  end

  def show
    @form = PreferenceForm.find(params[:id])
    @profiles = Profile.all
    @prefs = Preference.where(preference_form_id: @form.id, selector_id: current_user.id,
                              pref_type: 'Preference')
    @antiprefs = Preference.where(preference_form_id: @form.id, selector_id: current_user.id,
                                  pref_type: 'Anti-Preference')

    @questions = Question.where(preference_form_id: @form.id)
    @answers = Answer.where(user_id: current_user.id, preference_form_id: @form.id)

    # Checks if the form was complete before allowing the user to review responses.
    error_id = 0

    # Checks if all the questions were answered.
    @questions.each do |question|
      error_id = 1 if @answers.exists?(question_id: question.id) == false
    end

    if error_id.zero?
      if @prefs.size < @form.num_prefs
        # Checks if there were enough preferences made.
        error_id = 2
      elsif @antiprefs.size < @form.num_antiprefs
        # Checks if there were enough anti-preferences made
        error_id = 3
      end
    end

    # Takes the correct action based on the found error.
    case error_id
    when 1
      redirect_to(answers_path(form_id: @form.id), { flash: { danger: 'FORM NOT COMPLETE: please answer all questions before submitting.' } })
    when 2
      redirect_to(preferences_path(form_id: @form.id),
                  { flash: { danger: 'FORM NOT COMPLETE: missing one or more preferences. Use the "Add Pref" button to complete the form.' } })
    when 3
      redirect_to(preferences_path(form_id: @form.id),
                  { flash: { danger: 'FORM NOT COMPLETE: missing one or more anti-preferences. Use the "Add Anti-Pref" button to complete the form.' } })
    end
  end

  def new
    @form = PreferenceForm.new
  end

  def create
    @form = PreferenceForm.new(form_params)

    if @form.save
      redirect_to(questions_path(form_id: @form.id), { flash: { success: 'Form settings added successfully.' } })
    else
      render('new')
    end
  end

  def edit
    @form = PreferenceForm.find(params[:id])
  end

  def update
    @form = PreferenceForm.find(params[:id])
    if @form.update(form_params)
      redirect_to(preference_forms_path, { flash: { success: 'Form settings updated successfully.' } })
    else
      render('edit')
    end
  end

  def delete
    @form = PreferenceForm.find(params[:id])
  end

  def destroy
    @form = PreferenceForm.find(params[:id])
    @form.destroy
    redirect_to(preference_forms_path, { flash: { success: 'Form deleted successfully.' } })
  end

  private def form_params
    params.require(:preference_form).permit(:id, :title, :num_prefs, :num_antiprefs, :active)
  end
end
