class PreferencesController < ApplicationController
  
  $user_id = 1
  $form_id = 1

  def index
    @form = PreferenceForm.find($form_id)
    @users = User.where(:role => "Chair", :approved => TRUE).where.not(:id => $user_id)
    @prefs = Preference.where(:selector_id => $user_id, :pref_type => "Preference")
    @antiprefs = Preference.where(:selector_id => $user_id, :pref_type => "Anti-Preference")
  end

  def show
    @form = PreferenceForm.find($form_id)
    @users = User.where(:role => "Chair", :approved => TRUE).where.not(:id => $user_id)
    @prefs = Preference.where(:selector_id => $user_id, :pref_type => "Preference")
    @antiprefs = Preference.where(:selector_id => $user_id, :pref_type => "Anti-Preference")

    @questions = Question.order('id ASC')
    @answers = Answer.where(:user_id => $user_id)

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
    @users = User.where(:role => "Chair", :approved => TRUE).where.not(:id => $user_id)
    @pref = Preference.new(:selector_id => $user_id, :pref_type => params[:pref_type])
  end

  def create
    @pref = Preference.new(preferences_params)
    if @pref.save
      flash[:notice] = 'Preference Saved'
      redirect_to(preferences_path)
    else
      render('new')
    end
  end

  def edit
    @pref = Preference.find(params[:id])
    @users = User.where(:role => "Chair", :approved => TRUE).where.not(:id => $user_id)
  end

  def update
    @pref = Preference.find(params[:id])
    if @pref.update(preferences_params)
      flash[:notice] = 'Preference Updated'
      redirect_to(preferences_path)
    else
      render('new')
    end
  end

  def delete
    @pref = Preference.find(params[:id])
    @user = User.find(@pref.selected_id)
    @question = params[:question]
  end

  def destroy
    @pref = Preference.find(params[:id])
    if @pref.destroy
      flash[:notice] = 'Preference Deleted'
    end
    redirect_to(preferences_path)
  end

  private

    def preferences_params
      params.require(:preference).permit(:selector_id, :selected_id, :pref_type, :rating, :why)
    end
end
