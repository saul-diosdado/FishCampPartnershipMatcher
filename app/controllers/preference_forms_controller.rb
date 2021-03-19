# frozen_string_literal: true

class PreferenceFormsController < ApplicationController
  def index
    @forms = PreferenceForm.all
  end

  def show
    @form = PreferenceForm.find(params[:id])
    @users = User.where(:role => "Chair", :approved => TRUE).where.not(:id => current_user.id)
    @prefs = Preference.where(:preference_form_id => @form.id, :selector_id => current_user.id, :pref_type => "Preference")
    @antiprefs = Preference.where(:preference_form_id => @form.id, :selector_id => params[:user_id], :pref_type => "Anti-Preference")

    @questions = Question.order('id ASC')
    @answers = Answer.where(:user_id => params[:user_id])

    error_id = 0
    @questions.each do |question|
      if @answers.exists?(:question_id => question.id) == false
          error_id = 1
      end
    end

    if error_id == 0
      if @prefs.size < @form.num_prefs
        error_id = 2
      elsif @antiprefs.size < @form.num_antiprefs
        error_id = 3
      end
    end

    case error_id
    when 1
      flash[:notice] = 'FORM NOT COMPLETE. Please answer all questions before submitting.'
      redirect_to(answers_path)
    when 2
      flash[:notice] = 'FORM NOT COMPLETE. Missing one or more preferences. Use the "Add Preference" button to complete the form.'
      redirect_to(preferences_path)
    when 3
      flash[:notice] = 'FORM NOT COMPLETE. Missing one or more anti-preferences. Use the "Add Anti-Preference" button to complete the form.'
      redirect_to(preferences_path)
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
