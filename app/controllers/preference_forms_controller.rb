class PreferenceFormsController < ApplicationController
  def index
    @forms = PreferenceForm.all
  end

  def new
    @form = PreferenceForm.new
  end

  def create
    @form = PreferenceForm.new(form_params)

    if @form.save
      redirect_to(questions_path(:form_id => @form.id), {:flash => {:success => "Form settings added successfully."}})
    else
      render("new")
    end
  end

  def edit
    @form = PreferenceForm.find(params[:id])
  end

  def update
    @form = PreferenceForm.find(params[:id])
    if @form.update(form_params)
      redirect_to(preference_forms_path, {:flash => {:success => "Form settings updated successfully."}})
    else
      render("edit")
    end
  end

  def delete
    @form = PreferenceForm.find(params[:id])
  end

  def destroy
    @form = PreferenceForm.find(params[:id])
    @form.destroy
    redirect_to(preference_forms_path, {:flash => {:success => "Form deleted successfully."}})
  end

  private def form_params
    params.require(:preference_form).permit(:id, :title, :num_prefs, :num_antiprefs, :active)
  end
end
