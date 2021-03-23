class PreferencesController < ApplicationController
  before_action :require_login

  def index
    @form = PreferenceForm.find(params[:form_id])
    @users = User.where(:role => "Chair", :approved => TRUE).where.not(:id => current_user.id)
    @prefs = Preference.where(:preference_form_id => @form.id, :selector_id => current_user.id, :pref_type => "Preference")
    @antiprefs = Preference.where(:preference_form_id => @form.id, :selector_id => current_user.id, :pref_type => "Anti-Preference")
  end

  # def show
  #   @form = PreferenceForm.find(params[:form_id])
  #   @users = User.where(:role => "Chair", :approved => TRUE).where.not(:id => current_user.id)
  #   @prefs = Preference.where(:preference_form_id => @form.id, :selector_id => current_user.id, :pref_type => "Preference")
  #   @antiprefs = Preference.where(:preference_form_id => @form.id, :selector_id => params[:user_id], :pref_type => "Anti-Preference")

  #   @questions = Question.order('id ASC')
  #   @answers = Answer.where(:user_id => params[:user_id])

  #   error_id = 0
  #   @questions.each do |question|
  #     if @answers.exists?(:question_id => question.id) == false
  #         error_id = 1
  #     end
  #   end

  #   if error_id == 0
  #     if @prefs.size < @form.num_prefs
  #       error_id = 2
  #     elsif @antiprefs.size < @form.num_antiprefs
  #       error_id = 3
  #     end
  #   end

  #   case error_id
  #   when 1
  #     flash[:notice] = 'FORM NOT COMPLETE. Please answer all questions before submitting.'
  #     redirect_to(answers_path)
  #   when 2
  #     flash[:notice] = 'FORM NOT COMPLETE. Missing one or more preferences. Use the "Add Preference" button to complete the form.'
  #     redirect_to(preferences_path)
  #   when 3
  #     flash[:notice] = 'FORM NOT COMPLETE. Missing one or more anti-preferences. Use the "Add Anti-Preference" button to complete the form.'
  #     redirect_to(preferences_path)
  #   end
  # end

  def new
    @users = User.where(:role => "Chair", :approved => TRUE).where.not(:id => current_user.id)
    @profiles = Profile.all
    @pref = Preference.new(:preference_form_id => params[:form_id], :selector_id => current_user.id, :pref_type => params[:pref_type])
  end

  def create
    @pref = Preference.new(preferences_params)
    if @pref.save
      flash[:notice] = 'Preference Saved'
      redirect_to(preferences_path(:form_id => @pref.preference_form_id, :user_id => @pref.selector_id))
    else
      render('new')
    end
  end

  def edit
    @pref = Preference.find(params[:id])
    @profiles = Profile.all
    @users = User.where(role: 'Chair', approved: TRUE).where.not(id: params[:user_id])
  end

  def update
    @pref = Preference.find(params[:id])
    if @pref.update(preferences_params)
      flash[:notice] = 'Preference Updated'
      redirect_to(preferences_path(:form_id => @pref.preference_form_id, :user_id => @pref.selector_id))
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
    form_id = @pref.preference_form_id
    user_id = @pref.selector_id

    if @pref.destroy
      flash[:notice] = 'Preference Deleted'
    end
    redirect_to(preferences_path(:form_id => form_id, :user_id => user_id))
  end

  private

    def preferences_params
      params.require(:preference).permit(:preference_form_id, :selector_id, :selected_id, :pref_type, :rating, :why)
    end
end
